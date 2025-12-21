import 'package:flutter/material.dart';

class RecipeAllergens extends StatelessWidget {
  const RecipeAllergens({super.key, required this.allergens});

  final List<String> allergens;

  @override
  Widget build(BuildContext context) {
    if (allergens.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        const Icon(Icons.warning, size: 16, color: Colors.orange),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            'Allergens: ${allergens.join(", ")}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.orange[800]),
          ),
        ),
      ],
    );
  }
}
