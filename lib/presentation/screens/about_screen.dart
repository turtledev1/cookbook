import 'package:flutter/material.dart';
import 'package:cookbook/app_config.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  // Version from pubspec.yaml
  static const String appVersion = '1.0.0';
  static const String buildNumber = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // App Icon/Logo placeholder
          const Icon(
            Icons.restaurant_menu,
            size: 80,
            color: Color.fromRGBO(31, 137, 39, 1),
          ),
          const SizedBox(height: 16),

          // App Name
          const Text(
            'Personal Cookbook',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          // Version
          Text(
            'Version $appVersion ($buildNumber)',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          // Environment badge
          if (AppConfig.isDev)
            Center(
              child: Chip(
                label: const Text(
                  'DEV MODE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.orange,
              ),
            ),

          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 16),

          // Description
          const Text(
            'A Flutter recipe management app with Cloud Firestore sync for sharing recipes across devices.',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          // Feature list
          _buildFeatureSection(),

          const SizedBox(height: 32),

          // Environment info
          _buildEnvironmentSection(),
        ],
      ),
    );
  }

  Widget _buildFeatureSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Features',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _buildFeatureItem('Recipe CRUD operations'),
        _buildFeatureItem('Import recipes from HelloFresh'),
        _buildFeatureItem('Search and filter recipes'),
        _buildFeatureItem('Nutritional information tracking'),
        _buildFeatureItem('Allergen warnings'),
        _buildFeatureItem('Real-time sync across devices'),
      ],
    );
  }

  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            size: 20,
            color: Color.fromRGBO(31, 137, 39, 1),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              feature,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnvironmentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Environment',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _buildInfoRow('Mode', AppConfig.environment.toUpperCase()),
        _buildInfoRow('Collection', AppConfig.recipesCollection),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
