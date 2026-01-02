import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cookbook/domain/models/recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  const RecipeDetailScreen({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'recipe-image-${recipe.id}',
                child: recipe.imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: recipe.imageUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[300],
                          child: const Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(Icons.restaurant, size: 64, color: Colors.grey),
                          ),
                        ),
                      )
                    : Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.restaurant, size: 64, color: Colors.grey),
                        ),
                      ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    recipe.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Time and Difficulty Row
                  Row(
                    children: [
                      const Icon(Icons.schedule, size: 20),
                      const SizedBox(width: 8),
                      Text('Prep: ${recipe.prepTimeMinutes} min'),
                      const SizedBox(width: 16),
                      const Icon(Icons.restaurant, size: 20),
                      const SizedBox(width: 8),
                      Text('Cook: ${recipe.cookTimeMinutes} min'),
                      if (recipe.difficulty != null) ...[
                        const SizedBox(width: 16),
                        const Icon(Icons.signal_cellular_alt, size: 20),
                        const SizedBox(width: 8),
                        Text(_getDifficultyLabel(recipe.difficulty!)),
                      ],
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Tags
                  if (recipe.tags != null && recipe.tags!.isNotEmpty) ...[
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: recipe.tags!.map((tag) {
                        return Chip(
                          label: Text(tag),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Nutritional Info
                  const Text(
                    'Nutritional Information',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildNutritionChip(
                        '${recipe.nutritionalInfo.calories} kcal',
                        Icons.local_fire_department_outlined,
                      ),
                      if (recipe.nutritionalInfo.protein != null)
                        _buildNutritionChip(
                          '${recipe.nutritionalInfo.protein}g protein',
                          Icons.fitness_center,
                        ),
                      if (recipe.nutritionalInfo.carbs != null)
                        _buildNutritionChip(
                          '${recipe.nutritionalInfo.carbs}g carbs',
                          Icons.grain,
                        ),
                      if (recipe.nutritionalInfo.fat != null)
                        _buildNutritionChip(
                          '${recipe.nutritionalInfo.fat}g fat',
                          Icons.water_drop,
                        ),
                      if (recipe.nutritionalInfo.fiber != null)
                        _buildNutritionChip(
                          '${recipe.nutritionalInfo.fiber}g fiber',
                          Icons.eco,
                        ),
                      if (recipe.nutritionalInfo.sodium != null)
                        _buildNutritionChip(
                          '${recipe.nutritionalInfo.sodium}mg sodium',
                          Icons.spa,
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Allergens
                  if (recipe.allergens != null && recipe.allergens!.isNotEmpty) ...[
                    const Text(
                      'Allergens',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: recipe.allergens!.map((allergen) {
                        return Chip(
                          label: Text(allergen),
                          backgroundColor: Colors.orange.shade100,
                          labelStyle: TextStyle(color: Colors.orange.shade900),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Ingredients
                  const Text(
                    'Ingredients',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ...recipe.ingredients.map((ingredient) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.check_circle_outline, size: 20),
                          const SizedBox(width: 12),
                          Expanded(child: Text(ingredient)),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 24),

                  // Steps
                  const Text(
                    'Instructions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ...recipe.steps.asMap().entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 16,
                            child: Text('${entry.key + 1}'),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              entry.value,
                              style: const TextStyle(height: 1.5),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionChip(String label, IconData icon) {
    return Chip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 6,
        children: [
          Icon(icon, size: 16, color: Colors.grey[700]),
          Text(label),
        ],
      ),
      backgroundColor: const Color.fromRGBO(227, 234, 227, 1),
      labelStyle: TextStyle(color: Colors.grey[700]),
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
