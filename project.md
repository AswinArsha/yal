# Yalgamers App - Complete Documentation

## Overview

Yalgamers is a comprehensive gaming platform built with Flutter that combines social gaming features, quest systems, cryptocurrency integration, and NFT marketplace functionality. The app supports multi-platform deployment (Android, iOS, web, desktop) and uses PocketBase as the backend service.

## 🚀 Technology Stack

### Core Technologies
- **Framework**: Flutter 3.5.4+ with Dart SDK
- **State Management**: BLoC pattern (flutter_bloc 9.1.1)
- **UI Framework**: Material Design 3 with custom theming
- **Responsive Design**: flutter_screenutil for multi-device support
- **Authentication**: Google Sign-In + MetaMask wallet integration

### Backend Services
- **Primary Backend**: PocketBase (REST API)
- **Tournament Backend**: Separate microservice
- **Web3 Integration**: MetaMask + WalletConnect v2
- **Storage**: Secure storage with flutter_secure_storage

## 🎨 Design System

### Color Scheme
- **Background**: `#FF100613` (dark purple)
- **Primary**: `#FFF71756` (hot pink)
- **Secondary**: `#FFFDEB56` (yellow)
- **Text Primary**: White
- **Text Secondary**: White60
- **Cards**: `#FF1C121F`

### Typography
- **Font Family**: Google Fonts integration
- **Responsive**: ScreenUtil for scalable text
- **Hierarchy**: Multiple text styles for different contexts

## 📱 Core Features

### 1. Quest System
**Location**: `lib/feature/quest/`

#### Components
- **Models**: Project and Task data structures
- **Repositories**: CRUD operations for tasks and projects
- **BLoCs**: 
  - `ProjectBloc`: Manages project states
  - `TaskBloc`: Handles task operations
  - `SaveTaskBloc`: Manages task persistence

#### Task Types
- Account following tasks
- YouTube subscription tasks
- Website visits
- Rate articles
- Telegram joins

#### Screens
- Project screen with tab navigation
- Task screen with progress tracking
- Quest screen with rewards

### 2. Wallet Integration
**Location**: `lib/feature/wallet/`

#### Features
- **Crypto Support**: MetaMask integration for Web3 functionality
- **Payment Methods**: Credit card, MetaMask, and Yalgamers tokens
- **Screens**: Deposit, Send, History, and Main wallet views

### 3. Marketplace
**Location**: `lib/feature/marketplace/`

#### Features
- **NFT Support**: Collections and NFT cards
- **Sponsorship System**: Creator partnerships and memberships
- **Screens**: Marketplace, Collections, Profile, and Sponsors

### 4. Social Features
- **Find Players**: Search and connect with other gamers
- **Community**: Social networking and chat
- **Leaderboards**: Competitive ranking system
- **Tournaments**: Tournament participation and management

### 5. Authentication System
**Location**: `lib/feature/login/`

#### Features
- **Google Auth**: Complete OAuth2 flow with BLoC pattern
- **MetaMask Auth**: Web3 wallet authentication
- **Password Management**: Forgot password and OTP verification
- **User Management**: Profile creation and management

## 🏗️ Architecture

### Project Structure
```
lib/
├── core/                    # Core utilities and configurations
│   ├── constants/          # App constants and widgets
│   ├── db/                 # Database configurations
│   ├── secrets/            # API keys and URLs
│   └── theme/              # App theming and colors
├── feature/                # Feature-based modules (20+ features)
│   ├── quest/              # Quest system
│   ├── wallet/             # Crypto wallet
│   ├── marketplace/        # NFT marketplace
│   ├── login/              # Authentication
│   ├── homescreen/         # Main navigation
│   └── [other features]/   # 15+ other feature modules
└── main.dart               # App entry point
```

### Navigation Structure
- **Bottom Navigation**: 5 main tabs (Home, Quest, Find Players, Rewards, More)
- **Drawer Navigation**: Additional features and settings
- **Tab Navigation**: Project/Quest tabs with different states

## 🔧 Backend Configuration

### API Endpoints
```dart
// Primary Backend
static const String baseURL = 'https://new.backend.dev.yalgamers.gg';

// Authentication
static const String authURL = '$baseURL/auth/google/mobile-login';
static const String savePasswordURL = '$baseURL/auth/save-password';
static const String refreshURL = '$baseURL/auth/refresh';
static const String logoutURL = '$baseURL/auth/logout';
static const String whoamiURL = '$baseURL/auth/whoami';

// Task Management
static const String saveTaskUrl = '$baseURL/tasks/save-task';

// Tournament Backend
static const String tournamentBaseURL = 'https://tournaments.backend.dev.yalgamers.gg';
static const String tournamentApprovalURL = '$tournamentBaseURL/auth/authorize';

// Web3 Configuration
static const String wcProjectId = 'b8f6b7558b5302d8ff6a403f5286aa44';
```

## 📦 Dependencies

### Core Dependencies
- **flutter_bloc**: ^9.1.1 (State management)
- **google_sign_in**: ^6.3.0 (Google authentication)
- **walletconnect_flutter_v2**: 2.0.14 (Web3 wallet connection)
- **web3dart**: 2.7.3 (Ethereum blockchain interaction)
- **pocketbase**: 0.15.1 (Backend API client)

### UI Dependencies
- **flutter_screenutil**: ^5.9.3 (Responsive design)
- **google_fonts**: ^6.2.1 (Typography)
- **carousel_slider**: ^5.0.0 (Image carousels)
- **shimmer**: ^3.0.0 (Loading effects)
- **animate_do**: ^4.2.0 (Animation utilities)

### Utility Dependencies
- **shared_preferences**: ^2.5.3 (Local storage)
- **flutter_secure_storage**: ^9.2.4 (Secure storage)
- **image_picker**: ^1.1.2 (Media selection)
- **file_picker**: ^10.1.9 (File selection)
- **url_launcher**: ^6.3.1 (External links)
- **qr_flutter**: ^4.1.0 (QR code generation)

### Media Dependencies
- **youtube_player_flutter**: ^9.1.1 (YouTube integration)
- **video_player**: ^2.10.0 (Video playback)
- **audioplayers**: ^6.4.0 (Audio playback)

## 🎯 Platform Support

### Android
- **Application ID**: `com.yalgamers.app`
- **Min SDK**: Flutter default
- **Target SDK**: Flutter default
- **Build Configuration**: Complete Gradle setup

### iOS
- **Bundle ID**: Configured for App Store
- **Capabilities**: Google Sign-In integration
- **Entitlements**: Properly configured

### Web & Desktop
- **Web**: Flutter web support enabled
- **Desktop**: Windows, macOS, and Linux support

## 🚀 Getting Started

### Prerequisites
```bash
Flutter 3.5.4+
Dart SDK
Android Studio / Xcode
```

### Installation
1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Configure environment variables in `lib/core/secrets/app_secrets.dart`
4. Run the app:
   ```bash
   flutter run
   ```

### Build Commands
```bash
# Android
flutter build apk
flutter build appbundle

# iOS
flutter build ios

# Web
flutter build web

# Desktop
flutter build windows
flutter build macos
flutter build linux
```

## 🎮 Key Features Overview

### Quest System
- Complete daily and weekly quests
- Track progress with visual indicators
- Earn rewards and XP
- Multiple task types (social, gaming, content)

### Wallet Integration
- Connect MetaMask wallet
- Deposit and withdraw funds
- Transaction history
- Multiple payment methods

### Marketplace
- Browse NFT collections
- Purchase gaming assets
- Creator sponsorships
- Membership benefits

### Social Features
- Find and connect with gamers
- Join communities
- Participate in tournaments
- Leaderboard rankings

### Authentication
- Google Sign-In integration
- MetaMask wallet authentication
- Secure password management
- Profile customization

## 📁 Asset Structure

### Images & Icons
- **Logos**: App branding assets
- **Game Cards**: PUBG, FreeFire, and other game assets
- **Icons**: 100+ custom icons for navigation and actions
- **Backgrounds**: App backgrounds and textures

### Media
- **Sounds**: Audio effects (ding.mp3)
- **Videos**: Mystery box animations
- **Animations**: Custom loading and transition effects

## 🔐 Security Features

### Authentication
- OAuth2 with Google
- Web3 wallet authentication
- Secure token storage
- Session management

### Data Protection
- Encrypted storage for sensitive data
- Secure API communication
- Input validation and sanitization

## 🧪 Testing

### Test Structure
- **Unit Tests**: Basic test structure in `test/`
- **Widget Tests**: Flutter testing framework setup
- **Integration Tests**: End-to-end testing capabilities

### Code Quality
- **Linting**: Flutter lints configured
- **Analysis**: Strong mode analysis options
- **Code Formatting**: Consistent code style

## 🌟 Production Features

### Performance
- **Optimized Assets**: Compressed images and videos
- **Code Splitting**: Feature-based module organization
- **State Management**: Efficient BLoC pattern
- **Caching**: Strategic data caching

### Monitoring
- **Error Handling**: Comprehensive error boundaries
- **Loading States**: Shimmer effects and loading indicators
- **User Feedback**: Toast notifications and alerts

## 📊 Development Status

### Completed Features
- ✅ Complete authentication system
- ✅ Quest management system
- ✅ Wallet integration
- ✅ Marketplace functionality
- ✅ Social features
- ✅ Multi-platform support

### Ready for Production
- ✅ Environment configuration
- ✅ Security implementation
- ✅ Asset optimization
- ✅ Testing framework
- ✅ Build configurations

## 🤝 Contributing

### Development Guidelines
- Follow Flutter best practices
- Use BLoC pattern for state management
- Implement proper error handling
- Add comprehensive documentation
- Write unit tests for new features

### Code Style
- Follow effective Dart style guide
- Use meaningful variable names
- Add comments for complex logic
- Maintain consistent formatting

## 📞 Support

For technical support or questions about the implementation:
- Check the documentation in each feature module
- Review the BLoC implementations for state management patterns
- Examine the API integration examples in the repository classes

---

**Note**: This documentation provides a comprehensive overview of the Yalgamers app architecture. For detailed implementation specifics, refer to the individual feature directories and their respective documentation.
