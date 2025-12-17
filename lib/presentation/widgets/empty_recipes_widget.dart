import 'package:flutter/material.dart';

class EmptyRecipesWidget extends StatelessWidget {
  final bool isSearching;

  const EmptyRecipesWidget({super.key, required this.isSearching});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(isSearching ? Icons.search_off : Icons.restaurant_menu, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(isSearching ? 'No recipes found' : 'No recipes yet', style: Theme.of(context).textTheme.titleLarge),
          if (isSearching) ...[
            const SizedBox(height: 8),
            Text(
              'Try a different search term or filter',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
          ],
        ],
      ),
    );
  }
}
