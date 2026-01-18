import 'package:flutter/material.dart';
import 'package:cookbook/domain/models/recipe.dart';
import 'package:cookbook/presentation/widgets/recipe_list/recipe_card.dart';

class RecipeListView extends StatelessWidget {
  const RecipeListView({super.key, required this.recipes});

  final List<Recipe> recipes;

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
