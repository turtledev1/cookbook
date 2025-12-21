# Firebase Setup Guide

This guide will help you set up Cloud Firestore for your Cookbook app.

## Phase 1: Shared Recipes (You and Your Wife)

### Step 1: Create a Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project" or "Create a project"
3. Name it something like "personal-cookbook"
4. Disable Google Analytics (not needed for personal use)
5. Click "Create project"

### Step 2: Add Android App to Firebase

1. In Firebase Console, click the Android icon (⚙️ > Project Settings)
2. Click "Add app" and select Android
3. Enter your package name (found in `android/app/build.gradle.kts`, look for `applicationId`)
4. Download the `google-services.json` file
5. Place it in `android/app/` directory

### Step 3: Add iOS App to Firebase (if needed)

1. In Firebase Console, click the iOS icon
2. Enter your bundle ID (found in Xcode or `ios/Runner/Info.plist`)
3. Download the `GoogleService-Info.plist` file
4. Open `ios/Runner.xcworkspace` in Xcode
5. Drag `GoogleService-Info.plist` into the Runner folder in Xcode

### Step 4: Set Up Firestore Database

1. In Firebase Console, go to "Firestore Database"
2. Click "Create database"
3. **Start in Test Mode** (for now - see security notes below)
4. Choose a location (select one closest to you)
5. Click "Enable"

### Step 5: Configure Android Build Files

Edit `android/build.gradle.kts`:
```kotlin
buildscript {
    dependencies {
        // Add this line
        classpath("com.google.gms:google-services:4.4.0")
    }
}
```

Edit `android/app/build.gradle.kts`:
```kotlin
plugins {
    // ... existing plugins
    id("com.google.gms.google-services") // Add this line at the end
}
```

### Step 6: Install Dependencies & Run

```bash
# Install Flutter dependencies
flutter pub get

# Regenerate injection code
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

## Important: Firestore Security Rules

### For Phase 1 (Personal Use - You and Your Wife)

**Current Setting (Test Mode):** Anyone with your database URL can read/write

After 30 days, Firebase will disable test mode. Update your rules in Firebase Console:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow all users to read and write shared recipes
    match /shared_recipes/{recipe} {
      allow read, write: if true;
    }
  }
}
```

⚠️ **WARNING**: These rules allow anyone to access your database. Only use this for personal apps not distributed publicly.

### For Phase 2 (Play Store Deployment)

When deploying to Play Store, you'll want user-specific recipes:

1. **Update `lib/app_config.dart`:**
```dart
static const bool useSharedMode = false;
```

2. **Add Firebase Authentication:**
```bash
flutter pub add firebase_auth
```

3. **Update Firestore Rules:**
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Each user can only access their own recipes
    match /user_recipes/{userId}/recipes/{recipe} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

4. **Modify Data Source** to include user ID in the path

## Switching Between Local and Firestore

Edit `lib/app_config.dart`:

```dart
// For local development (faster, no internet needed)
static const String environment = 'local';

// For production with Firestore
static const String environment = 'firestore';
```

After changing, run:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Troubleshooting

### "MissingPluginException"
Run: `flutter clean && flutter pub get`

### "FirebaseException: Failed to get document"
- Check that `google-services.json` is in `android/app/`
- Check that `GoogleService-Info.plist` is in Xcode project
- Verify Firestore is enabled in Firebase Console

### "Permission Denied"
- Check Firestore Security Rules in Firebase Console
- Ensure rules allow read/write access

## Testing

Add some test data through Firebase Console:
1. Go to Firestore Database
2. Click "Start collection"
3. Collection ID: `shared_recipes`
4. Add a document with auto-generated ID
5. Add fields matching your Recipe model

## Architecture Benefits

Your current architecture makes future scaling easy:

✅ **Already done:**
- Clean separation: Data Sources → Repository → BLoC → UI
- Dependency injection with environment switching
- Abstract interfaces for easy swapping

📈 **Future enhancements (no rewrites needed):**
- Add user authentication → Update data source path
- Add offline caching → Wrap Firestore calls with cache
- Add image uploads → Add new methods to data source
- Multi-tenant (family sharing) → Update Firestore rules
- Recipe sharing → Add new methods without changing existing code

## Cost Estimates

**Firebase Free Tier:**
- 1 GB storage
- 50K reads/day
- 20K writes/day
- 20K deletes/day

For personal use with 2 users, you'll likely never exceed the free tier!

## Next Steps

1. Set up Firebase project
2. Add configuration files
3. Run `flutter pub get`
4. Run `flutter pub run build_runner build --delete-conflicting-outputs`
5. Deploy to your phones
6. Share and enjoy your recipes! 🍳
