import 'package:flutter/material.dart';

class RecipeIngredientsPreview extends StatelessWidget {
  final List<String> ingredients;
  final int maxVisible;

  const RecipeIngredientsPreview({
    super.key,
    required this.ingredients,
    this.maxVisible = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingredients (${ingredients.length})',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...ingredients.take(maxVisible).map(
              (ingredient) => Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• '),
                    Expanded(child: Text(ingredient)),
                  ],
                ),
              ),
            ),
        if (ingredients.length > maxVisible)
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              '... and ${ingredients.length - maxVisible} more',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
            ),
          ),
      ],
    );
  }
}
