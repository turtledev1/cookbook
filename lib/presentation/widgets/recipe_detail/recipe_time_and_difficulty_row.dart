import 'package:flutter/material.dart';
import 'package:cookbook/domain/models/recipe.dart';

class RecipeTimeAndDifficultyRow extends StatelessWidget {
  const RecipeTimeAndDifficultyRow({
    super.key,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    this.difficulty,
  });

  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final RecipeDifficulty? difficulty;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.schedule, size: 20),
        const SizedBox(width: 8),
        Text('Prep: $prepTimeMinutes min'),
        const SizedBox(width: 16),
        const Icon(Icons.restaurant, size: 20),
        const SizedBox(width: 8),
        Text('Cook: $cookTimeMinutes min'),
        if (difficulty != null) ...[
          const SizedBox(width: 16),
          const Icon(Icons.signal_cellular_alt, size: 20),
          const SizedBox(width: 8),
          Text(_getDifficultyLabel(difficulty!)),
        ],
      ],
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
