import 'package:flutter/material.dart';
import 'package:cookbook/domain/models/recipe.dart';

class NutritionalInfoSection extends StatelessWidget {
  const NutritionalInfoSection({super.key, required this.nutritionalInfo});

  final NutritionalInfo nutritionalInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nutritional Information',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: [
            _NutritionChip(
              label: '${nutritionalInfo.calories} kcal',
              icon: Icons.local_fire_department_outlined,
            ),
            if (nutritionalInfo.protein != null)
              _NutritionChip(
                label: '${nutritionalInfo.protein}g protein',
                icon: Icons.fitness_center,
              ),
            if (nutritionalInfo.carbs != null)
              _NutritionChip(
                label: '${nutritionalInfo.carbs}g carbs',
                icon: Icons.grain,
              ),
            if (nutritionalInfo.fat != null)
              _NutritionChip(
                label: '${nutritionalInfo.fat}g fat',
                icon: Icons.water_drop,
              ),
            if (nutritionalInfo.fiber != null)
              _NutritionChip(
                label: '${nutritionalInfo.fiber}g fiber',
                icon: Icons.eco,
              ),
            if (nutritionalInfo.sodium != null)
              _NutritionChip(
                label: '${nutritionalInfo.sodium}mg sodium',
                icon: Icons.spa,
              ),
          ],
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}

class _NutritionChip extends StatelessWidget {
  const _NutritionChip({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
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
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
    );
  }
}
