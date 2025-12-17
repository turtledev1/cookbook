import 'package:flutter/material.dart';
import '../../models/recipe.dart';

class RecipeNutritionInfo extends StatelessWidget {
  final NutritionalInfo nutritionalInfo;

  const RecipeNutritionInfo({super.key, required this.nutritionalInfo});

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
          _NutritionItem(label: 'Protein', value: '${nutritionalInfo.protein}g'),
          _NutritionItem(label: 'Carbs', value: '${nutritionalInfo.carbs}g'),
          _NutritionItem(label: 'Fat', value: '${nutritionalInfo.fat}g'),
        ],
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
