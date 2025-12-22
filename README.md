# Personal Cookbook

A Flutter recipe management app with Cloud Firestore sync for sharing recipes across devices.

## Prerequisites

- Flutter SDK (latest stable)
- Android Studio / Xcode for mobile development
- Firebase account (free tier is sufficient)

## Setup

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Generate Code

Run this to generate dependency injection and JSON serialization code:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Firebase Setup

The Firebase project is already configured. You need to download the configuration files:

#### Android Configuration
1. Go to [Firebase Console](https://console.firebase.google.com/) and open the cookbook project
2. Go to Project Settings → Your apps → Android app
3. Download `google-services.json`
4. Place in `android/app/`

#### iOS Configuration (Optional)
1. In Firebase Console → Project Settings → Your apps → iOS app
2. Download `GoogleService-Info.plist`
3. Open `ios/Runner.xcworkspace` in Xcode
4. Drag `GoogleService-Info.plist` into Runner folder

**Note**: Config files are not committed to git. You must download them from Firebase Console.

## Running the App

### Development (Dev Environment)
```bash
flutter run --dart-define-from-file=config/config.dev.json
```
- Uses `dev_shared_recipes` collection
- App title shows "(DEV)" badge

Alternatively, run without config file (defaults to dev):
```bash
flutter run
```

### Production (Prod Environment)
```bash
flutter run --dart-define-from-file=config/config.prod.json --release
```
- Uses `shared_recipes` collection
- For deployment to phones

## Environment Configuration

The app uses `--dart-define-from-file` to load environment-specific configuration:

- **`config/config.dev.json`**: Development environment (uses `dev_shared_recipes`)
- **`config/config.prod.json`**: Production environment (uses `shared_recipes`)

If no config file is specified, it defaults to dev settings.

### Configuration Files

Each config file should contain:
```json
{
  "ENVIRONMENT": "dev",
  "FIREBASE_COLLECTION_PREFIX": "dev_"
}
```

For production:
```json
{
  "ENVIRONMENT": "prod",
  "FIREBASE_COLLECTION_PREFIX": ""
}
```

**Note**: Config files are gitignored for security. Each developer should have their own copies.

## Troubleshooting

### Build errors after setup
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Firebase connection issues
- Verify `google-services.json` is in `android/app/`
- Check Firestore is enabled in Firebase Console
- Ensure security rules are published

### Can't see recipes on other device
- Both devices must be in release mode (or both in debug)
- Check Firebase Console to verify data is being written
- Firestore sync may take a few seconds

## Features

- ✅ Recipe CRUD operations
- ✅ Search and filter recipes
- ✅ Nutritional information tracking
- ✅ Allergen warnings
- ✅ Real-time sync across devices (Firestore)
- ✅ Automatic dev/prod environment separation

## Tech Stack

- **Flutter** - Cross-platform UI framework
- **Cloud Firestore** - Real-time database
- **Injectable/GetIt** - Dependency injection
- **Flutter BLoC** - State management
- **go_router** - Navigation
- **json_serializable** - JSON serialization
