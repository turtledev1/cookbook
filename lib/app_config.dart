class AppConfig {
  // Read environment from --dart-define-from-file
  // Defaults to 'dev' if not provided
  static const String environment = String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev');
  static const String collectionPrefix = String.fromEnvironment('FIREBASE_COLLECTION_PREFIX', defaultValue: 'dev_');

  // Set to true to use Firestore in shared mode (all users see same recipes)
  // Set to false for user-specific recipes (requires authentication)
  static const bool useSharedMode = true;

  // Firestore collection name with environment prefix
  static String get recipesCollection {
    return useSharedMode
        ? '${collectionPrefix}shared_recipes' // e.g., "dev_shared_recipes" or "shared_recipes"
        : '${collectionPrefix}user_recipes';
  }

  static bool get isDev => environment == 'dev';
  static bool get isProd => environment == 'prod';
}
