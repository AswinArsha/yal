import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:yalgamers/core/secrets/app_secrets.dart';

class WalletLoginWidget extends StatefulWidget {
  const WalletLoginWidget({super.key});

  @override
  WalletLoginWidgetState createState() => WalletLoginWidgetState();
}

class WalletLoginWidgetState extends State<WalletLoginWidget> {
  final storage = const FlutterSecureStorage();
  late final Web3App wcClient;
  bool loading = false;
  bool initialized = false;
  SessionData? currentSession;
  String? connectionStatus;

  @override
  void initState() {
    super.initState();
    initializeWalletConnect();
    _checkExistingSession();
  }

  Future<void> _checkExistingSession() async {
    try {
      final accessToken = await storage.read(key: 'accessToken');
      final walletAddress = await storage.read(key: 'walletAddress');

      if (accessToken != null && walletAddress != null) {
        // Check if token is still valid by making a test request
        final response = await http.get(
          Uri.parse('${AppUrls.backendURL}auth/verify'),
          headers: {'Authorization': 'Bearer $accessToken'},
        );

        if (response.statusCode == 200) {
          debugPrint('✅ Found valid existing session');
          setState(() {
            connectionStatus = 'Logged in with existing session';
          });
        } else {
          // Token expired, clear storage
          await _clearStoredTokens();
        }
      }
    } catch (e) {
      debugPrint('Error checking existing session: $e');
      await _clearStoredTokens();
    }
  }

  Future<void> _clearStoredTokens() async {
    await storage.delete(key: 'accessToken');
    await storage.delete(key: 'refreshToken');
    await storage.delete(key: 'walletAddress');
  }

  Future<void> initializeWalletConnect() async {
    try {
      wcClient = Web3App(
        core: Core(projectId: AppUrls.wcProjectId),
        metadata: const PairingMetadata(
          name: 'YalGamers',
          description: 'YalGamers Login',
          url: 'https://yalgamers.gg',
          icons: ['https://yalgamers.gg/favicon.icon'],
        ),
      );

      await wcClient.init();

      // Subscribe to session connect event
      wcClient.onSessionConnect.subscribe((event) {
        debugPrint('📱 Session connect event received');
        if (event != null) {
          _handleSessionConnect(event);
        }
      });

      // Listen to session delete (disconnect)
      wcClient.onSessionDelete.subscribe((event) {
        debugPrint('Session deleted: $event');
        setState(() {
          currentSession = null;
          connectionStatus = null;
        });
        _clearStoredTokens();
      });

      // Listen to session update events
      wcClient.onSessionUpdate.subscribe((event) {
        debugPrint('Session updated: $event');
      });

      // Listen to session events (like account changes)
      wcClient.onSessionEvent.subscribe((event) {
        debugPrint('Session event: $event');
        if (event?.name == 'accountsChanged') {
          // Handle account change
          _handleAccountChange(event!);
        }
      });

      setState(() {
        initialized = true;
      });

      debugPrint('✅ WalletConnect initialized successfully');
    } catch (e) {
      debugPrint('❌ Failed to initialize WalletConnect: $e');
      setState(() {
        connectionStatus = 'Failed to initialize: $e';
      });
    }
  }

  Future<void> _handleAccountChange(SessionEvent event) async {
    try {
      // Clear current session and tokens when account changes
      await disconnect();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account changed. Please reconnect.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error handling account change: $e');
    }
  }

  Future<void> _handleSessionConnect(SessionConnect event) async {
    debugPrint('🔗 Handling session connect...');

    final session = event.session;
    final topic = session.topic;

    // Check if we have accounts in the expected namespace
    if (!session.namespaces.containsKey('eip155') ||
        session.namespaces['eip155']!.accounts.isEmpty) {
      debugPrint('❌ No EIP155 accounts found in session');
      setState(() {
        loading = false;
        connectionStatus = 'No Ethereum accounts found';
      });
      return;
    }

    final address =
        session.namespaces['eip155']!.accounts.first.split(':').last;

    setState(() {
      currentSession = session;
      loading = false;
      connectionStatus = 'Connected to $address';
    });

    debugPrint('✅ Connected wallet: $address');

    try {
      setState(() {
        connectionStatus = 'Authenticating...';
      });

      // Step 1: Get nonce from backend
      const url = '${AppUrls.backendURL}auth/metamask/nonce';
      debugPrint('📡 Requesting nonce from backend...');
      final nonceRes = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'address': address}),
      );

      log('metamask address $address url is $url');

      if (nonceRes.statusCode != 201) {
        throw Exception('Failed to get nonce: ${nonceRes.body}');
      }

      final nonceData = jsonDecode(nonceRes.body);
      final nonce = nonceData['nonce'];
      debugPrint('✅ Nonce received: $nonce');

      // Sign only the nonce string (as requested by backend)
      final message = nonce;

      debugPrint('📝 Requesting signature for nonce: $message');

      // Step 2: Ask wallet to sign the nonce using personal_sign
      setState(() {
        connectionStatus = 'Please sign the message in your wallet...';
      });

      final sig = await wcClient.request(
        topic: topic,
        chainId: 'eip155:1',
        request: SessionRequestParams(
          method: 'personal_sign',
          params: [message, address],
        ),
      );

      debugPrint('✅ Signature received: $sig');

      setState(() {
        connectionStatus = 'Verifying signature...';
      });

      // Step 3: Verify signature with backend
      final verifyRes = await http.post(
        Uri.parse('${AppUrls.backendURL}auth/metamask/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'address': address,
          'signature': sig,
        }),
      );

      if (verifyRes.statusCode != 201) {
        throw Exception('Login verification failed: ${verifyRes.body}');
      }

      final response = jsonDecode(verifyRes.body);
      final accessToken = response['accessToken'];
      final refreshToken = response['refreshToken'];

      // Store tokens securely
      await storage.write(key: 'accessToken', value: accessToken);
      await storage.write(key: 'refreshToken', value: refreshToken);
      await storage.write(key: 'walletAddress', value: address);
      log('tokens $response $accessToken $refreshToken');

      setState(() {
        connectionStatus = 'Successfully authenticated!';
      });

      debugPrint('🎉 Login successful. Tokens saved.');

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      debugPrint('❌ Login error: $e');
      setState(() {
        connectionStatus = 'Authentication failed: $e';
        loading = false;
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> connectAndLogin() async {
    if (!initialized || loading) return;

    try {
      setState(() {
        loading = true;
        connectionStatus = 'Initializing connection...';
      });

      debugPrint('🔄 Starting wallet connection...');

      // Start connection timeout
      _startConnectionTimeout();

      // Create connection request with more specific parameters
      final ConnectResponse connectResponse = await wcClient.connect(
        requiredNamespaces: {
          'eip155': const RequiredNamespace(
            chains: ['eip155:1'], // Ethereum mainnet
            methods: [
              'personal_sign',
              'eth_sendTransaction',
              'eth_signTransaction',
              'eth_sign',
              'eth_sendRawTransaction',
            ],
            events: ['accountsChanged', 'chainChanged'],
          ),
        },
        optionalNamespaces: {
          'eip155': const RequiredNamespace(
            chains: [
              'eip155:137', // Polygon
              'eip155:56', // BSC
              'eip155:42161', // Arbitrum
            ],
            methods: [
              'personal_sign',
              'eth_sendTransaction',
            ],
            events: ['accountsChanged', 'chainChanged'],
          ),
        },
      );

      // Get the connection URI
      final uri = connectResponse.uri.toString();
      debugPrint('🔗 Connection URI: $uri');

      setState(() {
        connectionStatus = 'Waiting for wallet connection...';
      });

      await _showConnectionDialog(uri);
    } catch (e) {
      debugPrint('❌ Connection error: $e');
      setState(() {
        connectionStatus = 'Connection failed: $e';
        loading = false;
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Connection failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _startConnectionTimeout() async {
    await Future.delayed(const Duration(seconds: 30));
    if (loading && currentSession == null) {
      setState(() {
        loading = false;
        connectionStatus = 'Connection timed out. Please try again.';
      });
    }
  }

  Future<void> _showConnectionDialog(String uri) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Connect Your Wallet'),
          content: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Choose how you want to connect:',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),

                // MetaMask Mobile App Button with improved deep linking
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await _connectToMetaMask(uri);
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.phone_android),
                    label: const Text('Open MetaMask App'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  loading = false;
                  connectionStatus = null;
                });
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _connectToMetaMask(String uri) async {
    try {
      debugPrint('🦊 Connecting to MetaMask with URI: $uri');

      // URL encode the URI properly
      final encodedUri = Uri.encodeComponent(uri);

      // Try multiple MetaMask deep link formats in order of preference
      final List<String> deepLinks = [
        // MetaMask universal link (most reliable)
        'https://metamask.app.link/wc?uri=$encodedUri',
        // Direct MetaMask scheme
        'metamask://wc?uri=$encodedUri',
        // Alternative formats
        'https://metamask.app.link/connect?uri=$encodedUri',
        'metamask://connect?uri=$encodedUri',
      ];

      bool launched = false;

      for (final link in deepLinks) {
        try {
          debugPrint('🔗 Trying to launch: $link');
          final linkUri = Uri.parse(link);

          if (await canLaunchUrl(linkUri)) {
            debugPrint('✅ Launching: $link');
            await launchUrl(
              linkUri,
              mode: LaunchMode.externalApplication,
            );
            launched = true;

            // Show helpful message
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'MetaMask opened! Please approve the connection request.'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 4),
                ),
              );
            }
            break;
          } else {
            debugPrint('❌ Cannot launch: $link');
          }
        } catch (e) {
          debugPrint('❌ Failed to launch $link: $e');
          continue;
        }
      }

      if (!launched) {
        // Fallback: Try to open MetaMask app directly and give instructions
        try {
          final metamaskUri = Uri.parse('metamask://');
          if (await canLaunchUrl(metamaskUri)) {
            await launchUrl(metamaskUri, mode: LaunchMode.externalApplication);
          } else {
            throw Exception('MetaMask app not installed');
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'MetaMask app not found. Please install MetaMask from the App Store/Play Store.',
                ),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 5),
              ),
            );
          }
        }
      }
    } catch (e) {
      debugPrint('❌ MetaMask connection error: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to open MetaMask: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> disconnect() async {
    if (currentSession != null) {
      try {
        await wcClient.disconnectSession(
          topic: currentSession!.topic,
          reason: Errors.getSdkError(Errors.USER_DISCONNECTED),
        );

        // Clear stored data
        await _clearStoredTokens();

        setState(() {
          currentSession = null;
          connectionStatus = null;
        });

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Wallet disconnected')),
          );
        }
      } catch (e) {
        debugPrint('Disconnect error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Initializing WalletConnect...'),
          ],
        ),
      );
    }

    if (currentSession != null) {
      final address =
          currentSession!.namespaces['eip155']!.accounts.first.split(':').last;
      return Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 48),
                const SizedBox(height: 8),
                const Text(
                  'Wallet Connected',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '${address.substring(0, 6)}...${address.substring(address.length - 4)}',
                  style: const TextStyle(fontFamily: 'monospace'),
                ),
                if (connectionStatus != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    connectionStatus!,
                    style: TextStyle(
                      fontSize: 12,
                      color: connectionStatus!.contains('Success')
                          ? Colors.green
                          : connectionStatus!.contains('failed')
                              ? Colors.red
                              : Colors.orange,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: disconnect,
                  icon: const Icon(Icons.logout),
                  label: const Text('Disconnect'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Center(
      child: loading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(connectionStatus ?? 'Connecting to wallet...'),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    setState(() {
                      loading = false;
                      connectionStatus = null;
                    });
                  },
                  child: const Text('Cancel'),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: connectAndLogin,
                  icon: const Icon(Icons.account_balance_wallet),
                  label: const Text('Login with Wallet'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                ),
                if (connectionStatus != null) ...[
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      connectionStatus!,
                      style: TextStyle(
                        fontSize: 12,
                        color: connectionStatus!.contains('failed')
                            ? Colors.red
                            : Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ],
            ),
    );
  }

  // @override
  // void dispose() {
  //   // Clean up subscriptions
  //   wcClient.onSessionConnect.unsubscribe();
  //   wcClient.onSessionDelete.unsubscribe();
  //   wcClient.onSessionUpdate.unsubscribe();
  //   wcClient.onSessionEvent.unsubscribe();
  //   super.dispose();
  // }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('YalGamers Login')),
      body: const WalletLoginWidget(),
    ),
  ));
}
