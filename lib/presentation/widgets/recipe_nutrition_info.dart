import 'package:flutter/material.dart';
import 'package:cookbook/domain/models/recipe.dart';

class RecipeNutritionInfo extends StatelessWidget {
  const RecipeNutritionInfo({super.key, required this.nutritionalInfo});

  final NutritionalInfo nutritionalInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NutritionItem(label: 'Calories', value: '${nutritionalInfo.calories}'),
          if (nutritionalInfo.protein != null)
            _NutritionItem(label: 'Protein', value: '${nutritionalInfo.protein}g'),
          if (nutritionalInfo.carbs != null)
            _NutritionItem(label: 'Carbs', value: '${nutritionalInfo.carbs}g'),
          if (nutritionalInfo.fat != null)
            _NutritionItem(label: 'Fat', value: '${nutritionalInfo.fat}g'),
        ],
      ),
    );
  }
}

class _NutritionItem extends StatelessWidget {
  const _NutritionItem({required this.label, required this.value});
  final String label;
  final String value;

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
