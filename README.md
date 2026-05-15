# Quran Journey

A comprehensive Flutter application for Quran learning, memorization, and spiritual journey tracking.

## Features

### Core Features
- **Quran Library**: Complete Quran text with beautiful typography using Google Fonts
- **Audio Playback**: Integrated audio player for listening to Quran recitations
- **Memorization Tools**: Built-in tools to help with Quran memorization (Hifz)
- **Progress Tracking**: Visual charts and analytics to track your learning progress
- **Bookmarks**: Save and organize your favorite verses and pages
- **Review System**: Spaced repetition system for reviewing memorized content

### Authentication & User Management
- **Firebase Authentication**: Secure login with email/password
- **Google Sign-In**: Quick authentication with Google account
- **Profile Management**: Customize your learning experience

### Additional Features
- **Onboarding**: Guided introduction for new users
- **Dashboard**: Overview of your daily activities and achievements
- **Settings**: Customizable app preferences
- **Local Notifications**: Reminders for prayer times and memorization goals
- **Offline Support**: Local data storage using Hive
- **Responsive Design**: Works seamlessly on mobile, tablet, web, and desktop

## Tech Stack

### Frontend
- **Flutter** - Cross-platform UI framework
- **Riverpod** - State management
- **GoRouter** - Navigation and routing
- **Google Fonts** - Beautiful Arabic typography
- **Flutter Animate** - Smooth animations

### Backend & Services
- **Firebase Core** - Backend infrastructure
- **Firebase Auth** - User authentication
- **Cloud Firestore** - NoSQL database
- **Firebase Storage** - File storage
- **Firebase Messaging** - Push notifications
- **Firebase Crashlytics** - Crash reporting
- **Firebase Analytics** - Usage analytics
- **Firebase App Check** - App security

### Local Storage
- **Hive** - Fast, lightweight local database
- **Path Provider** - File system access

### Audio
- **Just Audio** - Audio playback
- **Audio Service** - Background audio support
- **Audio Session** - Audio session management

### Other Dependencies
- **Flutter Local Notifications** - Local notifications
- **Permission Handler** - Runtime permissions
- **FL Chart** - Data visualization
- **HTTP** - Network requests
- **Quran** - Quran text data
- **Intl** - Internationalization
- **Responsive Framework** - Adaptive layouts

## Getting Started

### Prerequisites
- Flutter SDK (>=3.9.0 <4.0.0)
- Dart SDK
- Firebase project setup
- Android Studio / VS Code
- Xcode (for iOS development)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd quran_journey
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code for Hive**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Configure Firebase**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Add your platform-specific configuration files:
     - `google-services.json` for Android (place in `android/app/`)
     - `GoogleService-Info.plist` for iOS (place in `ios/Runner/`)
   - Enable required Firebase services:
     - Authentication (Email/Password, Google Sign-In)
     - Cloud Firestore
     - Storage
     - Messaging
     - Crashlytics
     - Analytics

5. **Run the app**
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── app/                      # App-level configurations
├── core/                     # Core utilities and base classes
├── features/                 # Feature modules
│   ├── app_launch/          # App initialization
│   ├── audio/               # Audio playback feature
│   ├── auth/                # Authentication
│   ├── bookmarks/           # Bookmark management
│   ├── dashboard/           # Main dashboard
│   ├── home/                # Home screen
│   ├── memorization/        # Memorization tools
│   ├── onboarding/          # Onboarding flow
│   ├── profile/             # User profile
│   ├── progress/            # Progress tracking
│   ├── quran_library/       # Quran reader
│   ├── review/              # Review system
│   └── settings/            # App settings
├── injection/                # Dependency injection
└── shared/                   # Shared widgets and utilities
```

## Assets

The app includes the following asset directories:
- `assets/audio/` - Audio files
- `assets/data/` - Data files
- `assets/fonts/` - Custom fonts
- `assets/icons/` - Icon assets
- `assets/images/` - Image assets

## Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## Testing

Run tests using:
```bash
flutter test
```

Run integration tests:
```bash
flutter test integration_test/
```

## Building for Production

### Android
```bash
flutter build apk --release
# or for app bundle
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

### Desktop
```bash
flutter build windows --release
flutter build macos --release
flutter build linux --release
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- [Flutter](https://flutter.dev/)
- [Firebase](https://firebase.google.com/)
- [Quran.com API](https://quran.com/)
- All contributors and supporters

## Contact

For questions or support, please open an issue in the repository.
