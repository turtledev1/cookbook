# Quick Start Guide

## ✅ What's Been Set Up

Your app now supports **Cloud Firestore** for shared recipe storage! Here's what was implemented:

### 1. **Environment-Based Architecture**
- Switch between `local` (dev) and `firestore` (production) by editing one line in [app_config.dart](lib/app_config.dart)
- No code rewrites needed - just configuration changes!

### 2. **Files Modified**
- ✅ [pubspec.yaml](pubspec.yaml) - Added Firebase dependencies
- ✅ [app_config.dart](lib/app_config.dart) - NEW: Environment configuration
- ✅ [main.dart](lib/main.dart) - Firebase initialization
- ✅ [injection.dart](lib/injection.dart) - Firebase dependency injection
- ✅ [recipe_repository.dart](lib/domain/repositories/recipe_repository.dart) - Auto-selects data source
- ✅ [recipe_firestore_data_source.dart](lib/data/data_sources/recipe_firestore_data_source.dart) - Firestore implementation

## 🚀 Next Steps

### Step 1: Set Up Firebase Project (15 minutes)
Follow the detailed guide in [FIREBASE_SETUP.md](FIREBASE_SETUP.md)

Key actions:
1. Create Firebase project at https://console.firebase.google.com/
2. Add Android app, download `google-services.json` → place in `android/app/`
3. (Optional) Add iOS app, download `GoogleService-Info.plist` → add to Xcode
4. Enable Firestore Database in Firebase Console
5. Update Android build files

### Step 2: Switch to Firestore Mode

Edit `lib/app_config.dart`:
```dart
static const String environment = 'firestore';  // Changed from 'local'
```

Then run:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

### Step 3: Deploy to Your Phones
```bash
# Connect your phone via USB or use wireless debugging
flutter run --release

# For your wife's phone, repeat the process
```

## 🎯 How It Works

### Shared Mode (Phase 1 - Current Setup)
- You and your wife share the **same** recipe collection
- Collection name: `shared_recipes`
- Add a recipe on your phone → It appears on your wife's phone instantly!
- Perfect for 2-person use

### User-Specific Mode (Phase 2 - Future)
When you deploy to Play Store, change one line in [app_config.dart](lib/app_config.dart):
```dart
static const bool useSharedMode = false;
```

Then add Firebase Authentication. Each user gets their own recipes.

## 🔧 Development Workflow

### Testing Locally (No Internet Needed)
```dart
// app_config.dart
static const String environment = 'local';
```

### Testing with Firestore
```dart
// app_config.dart
static const String environment = 'firestore';
```

After changing environment:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## 📱 Architecture Benefits

Your clean architecture means **no rewrites** for future features:

| Feature | Changes Needed |
|---------|----------------|
| Add offline caching | Wrap data source methods |
| Add image uploads | New method in data source |
| User authentication | Update config, modify data source path |
| Recipe sharing | New methods in data source |
| Multi-tenant | Update Firestore rules |

Everything works through the same Repository → BLoC → UI flow!

## 🆘 Troubleshooting

### App crashes on startup
- Make sure you ran `flutter pub run build_runner build`
- If using Firestore, ensure Firebase is set up correctly
- Switch back to `local` mode to test without Firebase

### Can't see recipes from other device
- Check that both devices are using `environment = 'firestore'`
- Verify Firestore rules allow read/write
- Check Firebase Console → Firestore Database to see if data is being written

### "Permission Denied" error
- Update Firestore Security Rules (see [FIREBASE_SETUP.md](FIREBASE_SETUP.md))

## 📊 Cost (Free Tier)
- **Storage**: 1 GB
- **Reads**: 50,000/day
- **Writes**: 20,000/day

For 2 users, you'll **never** hit these limits! 🎉

---

**Ready to start?** Head to [FIREBASE_SETUP.md](FIREBASE_SETUP.md) for detailed Firebase setup instructions!
