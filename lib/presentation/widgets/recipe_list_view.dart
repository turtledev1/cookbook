import 'package:flutter/material.dart';
import '../../domain/models/recipe.dart';
import 'recipe_card.dart';

class RecipeListView extends StatelessWidget {
  final List<Recipe> recipes;

  const RecipeListView({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return RecipeCard(recipe: recipe);
      },
    );
  }
}
