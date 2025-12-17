import 'package:flutter/material.dart';

class RecipeHeader extends StatelessWidget {
  final String recipeName;

  const RecipeHeader({super.key, required this.recipeName});

  @override
  Widget build(BuildContext context) {
    return Text(
      recipeName,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
