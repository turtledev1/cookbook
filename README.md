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

### Development (Debug Mode)
```bash
flutter run
```
- Uses `dev_shared_recipes` collection
- App title shows "(DEV)" badge

### Production (Release Mode)
```bash
flutter run --release
```
- Uses `shared_recipes` collection
- For deployment to phones

### Local Mode (No Firebase)
```bash
flutter run --dart-define=ENV=local
```
- Uses in-memory storage
- No internet required

## Environment Configuration

Debug builds automatically use dev environment, release builds use prod. Collections are separated by name (`dev_shared_recipes` vs `shared_recipes`) in the same Firebase project.

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
