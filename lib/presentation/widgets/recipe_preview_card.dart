import 'package:flutter/material.dart';
import 'package:cookbook/domain/models/recipe.dart';

class RecipePreviewCard extends StatelessWidget {
  const RecipePreviewCard({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recipe.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.schedule, size: 20, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Text('Prep: ${recipe.prepTimeMinutes} min'),
                const SizedBox(width: 16),
                Icon(Icons.restaurant, size: 20, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Text('Cook: ${recipe.cookTimeMinutes} min'),
                if (recipe.difficulty != null) ...[
                  const SizedBox(width: 16),
                  Icon(Icons.signal_cellular_alt, size: 20, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text(_getDifficultyLabel(recipe.difficulty!)),
                ],
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'Ingredients:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...recipe.ingredients.map(
              (ingredient) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_outline, size: 16),
                    const SizedBox(width: 8),
                    Expanded(child: Text(ingredient)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'Steps:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...recipe.steps.asMap().entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 12,
                      child: Text('${entry.key + 1}'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Text(entry.value)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'Nutritional Info:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _buildNutritionChip('${recipe.nutritionalInfo.calories} kcal', Icons.local_fire_department),
                if (recipe.nutritionalInfo.protein != null)
                  _buildNutritionChip('${recipe.nutritionalInfo.protein}g protein', Icons.fitness_center),
                if (recipe.nutritionalInfo.carbs != null)
                  _buildNutritionChip('${recipe.nutritionalInfo.carbs}g carbs', Icons.grain),
                if (recipe.nutritionalInfo.fat != null)
                  _buildNutritionChip('${recipe.nutritionalInfo.fat}g fat', Icons.water_drop),
                if (recipe.nutritionalInfo.fiber != null)
                  _buildNutritionChip('${recipe.nutritionalInfo.fiber}g fiber', Icons.eco),
                if (recipe.nutritionalInfo.sodium != null)
                  _buildNutritionChip('${recipe.nutritionalInfo.sodium}mg sodium', Icons.spa),
              ],
            ),
            if (recipe.allergens != null && recipe.allergens!.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              const Text(
                'Allergens:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: recipe.allergens!
                    .map(
                      (allergen) => Chip(
                        label: Text(allergen),
                        backgroundColor: Colors.orange.shade100,
                      ),
                    )
                    .toList(),
              ),
            ],
            if (recipe.tags != null && recipe.tags!.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              const Text(
                'Tags:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: recipe.tags!
                    .map(
                      (tag) => Chip(
                        label: Text(tag),
                        backgroundColor: Colors.blue.shade100,
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionChip(String label, IconData icon) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
      backgroundColor: Colors.green.shade100,
    );
  }

  String _getDifficultyLabel(RecipeDifficulty difficulty) {
    switch (difficulty) {
      case RecipeDifficulty.easy:
        return 'Easy';
      case RecipeDifficulty.medium:
        return 'Medium';
      case RecipeDifficulty.hard:
        return 'Hard';
    }
  }
}
