import 'package:flutter/material.dart';

class RecipeHeader extends StatelessWidget {
  const RecipeHeader({super.key, required this.recipeName});

  final String recipeName;

  @override
  Widget build(BuildContext context) {
    return Text(
      recipeName,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
