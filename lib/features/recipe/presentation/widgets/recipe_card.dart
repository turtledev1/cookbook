import 'package:flutter/material.dart';
import '../../models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Name
            Text(
              recipe.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Time Info
            Row(
              children: [
                const Icon(Icons.schedule, size: 16),
                const SizedBox(width: 4),
                Text(
                  'Prep: ${recipe.prepTimeMinutes}m | Cook: ${recipe.cookTimeMinutes}m | Total: ${recipe.totalTimeMinutes}m',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Tags
            if (recipe.tags != null && recipe.tags!.isNotEmpty)
              Wrap(
                spacing: 8,
                children: recipe.tags!
                    .map((tag) => Chip(label: Text(tag), labelStyle: const TextStyle(fontSize: 12)))
                    .toList(),
              ),
            const SizedBox(height: 12),

            // Ingredients
            Text(
              'Ingredients (${recipe.ingredients.length})',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...recipe.ingredients
                .take(3)
                .map(
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
            if (recipe.ingredients.length > 3)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  '... and ${recipe.ingredients.length - 3} more',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
                ),
              ),
            const SizedBox(height: 12),

            // Steps
            Text(
              'Steps (${recipe.steps.length})',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...recipe.steps
                .take(2)
                .map(
                  (step) => Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${recipe.steps.indexOf(step) + 1}. '),
                        Expanded(child: Text(step)),
                      ],
                    ),
                  ),
                ),
            if (recipe.steps.length > 2)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  '... ${recipe.steps.length - 2} more steps',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
                ),
              ),
            const SizedBox(height: 12),

            // Nutritional Info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NutritionItem(label: 'Calories', value: '${recipe.nutritionalInfo.calories}'),
                  _NutritionItem(label: 'Protein', value: '${recipe.nutritionalInfo.protein}g'),
                  _NutritionItem(label: 'Carbs', value: '${recipe.nutritionalInfo.carbs}g'),
                  _NutritionItem(label: 'Fat', value: '${recipe.nutritionalInfo.fat}g'),
                ],
              ),
            ),

            // Allergens
            if (recipe.allergens != null && recipe.allergens!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.warning, size: 16, color: Colors.orange),
                  const SizedBox(width: 4),
                  Text(
                    'Allergens: ${recipe.allergens!.join(", ")}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.orange[800]),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _NutritionItem extends StatelessWidget {
  final String label;
  final String value;

  const _NutritionItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
