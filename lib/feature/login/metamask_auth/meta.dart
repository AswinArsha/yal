import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:yalgamers/core/secrets/app_secrets.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/sign_up/presentation/pages/google_setup_password.dart';

class WalletAuthService {
  static final WalletAuthService _instance = WalletAuthService._internal();
  factory WalletAuthService() => _instance;
  WalletAuthService._internal();

  final storage = const FlutterSecureStorage();
  Web3App? wcClient;
  bool initialized = false;
  SessionData? currentSession;

  Future<void> initialize(BuildContext context) async {
    if (initialized) return;

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

      await wcClient!.init();

      // Subscribe to session connect event
      wcClient!.onSessionConnect.subscribe((event) {
        if (event != null) {
          _handleSessionConnect(event, context);
        }
      });

      initialized = true;
      debugPrint('✅ WalletConnect initialized successfully');
    } catch (e) {
      debugPrint('❌ Failed to initialize WalletConnect: $e');
      rethrow;
    }
  }

  Future<bool> connectAndLogin(BuildContext context) async {
    if (!initialized) {
      await initialize(context);
    }

    try {
      // Show loading dialog
      _showLoadingDialog(context, 'Initializing connection...');

      debugPrint('🔄 Starting wallet connection...');

      final ConnectResponse connectResponse = await wcClient!.connect(
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

      final uri = connectResponse.uri.toString();
      debugPrint('🔗 Connection URI: $uri');

      // Close loading dialog and show connection dialog
      Navigator.of(context).pop();
      await _showConnectionDialog(context, uri);

      return true;
    } catch (e) {
      debugPrint('❌ Connection error: $e');
      Navigator.of(context).pop(); // Close loading dialog
      _showErrorSnackBar(context, 'Connection failed: $e');
      return false;
    }
  }

  Future<void> _handleSessionConnect(
      SessionConnect event, BuildContext context) async {
    debugPrint('🔗 Handling session connect...');

    final session = event.session;
    final topic = session.topic;

    if (!session.namespaces.containsKey('eip155') ||
        session.namespaces['eip155']!.accounts.isEmpty) {
      debugPrint('❌ No EIP155 accounts found in session');
      return;
    }

    final address =
        session.namespaces['eip155']!.accounts.first.split(':').last;
    currentSession = session;

    debugPrint('✅ Connected wallet: $address');

    try {
      // Step 1: Get nonce from backend
      const url = '${AppUrls.backendURL}auth/metamask/nonce';
      debugPrint('📡 Requesting nonce from backend...');

      final nonceRes = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'address': address}),
      );

      if (nonceRes.statusCode != 201) {
        throw Exception('Failed to get nonce: ${nonceRes.body}');
      }

      final nonceData = jsonDecode(nonceRes.body);
      final nonce = nonceData['nonce'];
      debugPrint('✅ Nonce received: $nonce');

      // Step 2: Sign the nonce
      final sig = await wcClient!.request(
        topic: topic,
        chainId: 'eip155:1',
        request: SessionRequestParams(
          method: 'personal_sign',
          params: [nonce, address],
        ),
      );

      debugPrint('✅ Signature received: $sig');

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

      debugPrint("'refresh token' $refreshToken");
      debugPrint("'access token' $accessToken");

      // Store tokens securely
      await storage.write(key: 'accessToken', value: accessToken);
      await storage.write(key: 'refreshToken', value: refreshToken);
      await storage.write(key: 'walletAddress', value: address);

      debugPrint('🎉 Login successful. Tokens saved. $response');

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const GoogleSetupPassword()),
      );
    } catch (e) {
      debugPrint('❌ Login error: $e');
      rethrow;
    }
  }

  void _showLoadingDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
  }

  Future<void> _showConnectionDialog(BuildContext context, String uri) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1C121F), // dark card background
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Connect Your Wallet',
            style: AppTextStyles.medium(
              size: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Choose how you want to connect:',
                  style: AppTextStyles.small(
                    size: 12,
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await _connectToMetaMask(uri);
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.phone_android,
                      size: 18,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Open MetaMask App',
                      style: AppTextStyles.small(
                        size: 14,
                        color: Colors.white, // dark text for contrast
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFFF89C35), // your custom yellow
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: AppTextStyles.small(
                  size: 12,
                  color: Colors.white54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _connectToMetaMask(String uri) async {
    try {
      debugPrint('🦊 Connecting to MetaMask with URI: $uri');

      final encodedUri = Uri.encodeComponent(uri);
      final List<String> deepLinks = [
        'https://metamask.app.link/wc?uri=$encodedUri',
        'metamask://wc?uri=$encodedUri',
        'https://metamask.app.link/connect?uri=$encodedUri',
        'metamask://connect?uri=$encodedUri',
      ];

      bool launched = false;

      for (final link in deepLinks) {
        try {
          final linkUri = Uri.parse(link);
          if (await canLaunchUrl(linkUri)) {
            await launchUrl(linkUri, mode: LaunchMode.externalApplication);
            launched = true;
            break;
          }
        } catch (e) {
          continue;
        }
      }

      if (!launched) {
        final metamaskUri = Uri.parse('metamask://');
        if (await canLaunchUrl(metamaskUri)) {
          await launchUrl(metamaskUri, mode: LaunchMode.externalApplication);
        } else {
          throw Exception('MetaMask app not installed');
        }
      }
    } catch (e) {
      debugPrint('❌ MetaMask connection error: $e');
      rethrow;
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }
}
