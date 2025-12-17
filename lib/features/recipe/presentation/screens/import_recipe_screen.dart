import 'package:flutter/material.dart';

class ImportRecipeScreen extends StatelessWidget {
  const ImportRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Import Recipe'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Import a recipe from a website',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Website URL',
                hintText: 'https://example.com/recipe',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.link),
              ),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement URL parsing
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Import functionality coming soon!')),
                );
              },
              icon: const Icon(Icons.download),
              label: const Text('Import Recipe'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Recipe parser will be implemented here to extract recipe data from websites.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
