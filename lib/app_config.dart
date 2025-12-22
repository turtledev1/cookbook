enum BuildEnvironment {
  dev,
  prod,
  local, // For offline development
}

class AppConfig {
  // This will be set at app startup
  static BuildEnvironment _buildEnvironment = BuildEnvironment.dev;

  static void initialize({required BuildEnvironment environment}) {
    _buildEnvironment = environment;
  }

  static BuildEnvironment get buildEnvironment => _buildEnvironment;

  // Set to true to use Firestore in shared mode (all users see same recipes)
  // Set to false for user-specific recipes (requires authentication)
  static const bool useSharedMode = true;

  // Firestore collection name with environment prefix
  static String get recipesCollection {
    final prefix = _buildEnvironment == BuildEnvironment.prod ? '' : '${_buildEnvironment.name}_';
    return useSharedMode
        ? '${prefix}shared_recipes' // e.g., "dev_shared_recipes" or "shared_recipes"
        : '${prefix}user_recipes';
  }

  static bool get useFirestore => _buildEnvironment != BuildEnvironment.local;
  static bool get useLocal => _buildEnvironment == BuildEnvironment.local;
  static bool get isDev => _buildEnvironment == BuildEnvironment.dev;
  static bool get isProd => _buildEnvironment == BuildEnvironment.prod;
}
