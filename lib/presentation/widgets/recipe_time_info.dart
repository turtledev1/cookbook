import 'package:flutter/material.dart';

class RecipeTimeInfo extends StatelessWidget {
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final int totalTimeMinutes;

  const RecipeTimeInfo({
    super.key,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.totalTimeMinutes,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.schedule, size: 16),
        const SizedBox(width: 4),
        Text(
          'Prep: ${prepTimeMinutes}m | Cook: ${cookTimeMinutes}m | Total: ${totalTimeMinutes}m',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
