import 'package:flutter/material.dart';
import '../../domain/models/recipe.dart';
import 'recipe_header.dart';
import 'recipe_time_info.dart';
import 'recipe_tags.dart';
import 'recipe_ingredients_preview.dart';
import 'recipe_steps_preview.dart';
import 'recipe_nutrition_info.dart';
import 'recipe_allergens.dart';

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
            RecipeHeader(recipeName: recipe.name),
            const SizedBox(height: 12),
            RecipeTimeInfo(
              prepTimeMinutes: recipe.prepTimeMinutes,
              cookTimeMinutes: recipe.cookTimeMinutes,
              totalTimeMinutes: recipe.totalTimeMinutes,
            ),
            const SizedBox(height: 8),
            if (recipe.tags != null && recipe.tags!.isNotEmpty) ...[
              RecipeTags(tags: recipe.tags!),
              const SizedBox(height: 12),
            ],
            RecipeIngredientsPreview(ingredients: recipe.ingredients),
            const SizedBox(height: 12),
            RecipeStepsPreview(steps: recipe.steps),
            const SizedBox(height: 12),
            RecipeNutritionInfo(nutritionalInfo: recipe.nutritionalInfo),
            if (recipe.allergens != null && recipe.allergens!.isNotEmpty) ...[
              const SizedBox(height: 12),
              RecipeAllergens(allergens: recipe.allergens!),
            ],
          ],
        ),
      ),
    );
  }
}
