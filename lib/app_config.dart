class AppConfig {
  // Options: 'local' or 'firestore'
  static const String environment = 'firestore';

  // Set to true to use Firestore in shared mode (all users see same recipes)
  // Set to false for user-specific recipes (requires authentication)
  static const bool useSharedMode = true;

  // Firestore collection name
  static const String recipesCollection = useSharedMode
      ? 'shared_recipes' // All users share this collection
      : 'user_recipes'; // Each user has their own recipes

  static bool get useFirestore => environment == 'firestore';
  static bool get useLocal => environment == 'local';
}
