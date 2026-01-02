import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cookbook/router_names.dart';
import 'package:cookbook/domain/models/recipe.dart';
import 'package:cookbook/presentation/screens/recipe_list_screen.dart';
import 'package:cookbook/presentation/screens/create_recipe_screen.dart';
import 'package:cookbook/presentation/screens/import_recipe_screen.dart';
import 'package:cookbook/presentation/screens/recipe_detail_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: RouteNames.home,
      builder: (context, state) => const RecipeListScreen(),
    ),
    GoRoute(
      path: '/create',
      name: RouteNames.createRecipe,
      builder: (context, state) => const CreateRecipeScreen(),
    ),
    GoRoute(
      path: '/import',
      name: RouteNames.importRecipe,
      builder: (context, state) => const ImportRecipeScreen(),
    ),
    GoRoute(
      path: '/recipe/:id',
      name: RouteNames.recipeDetail,
      builder: (context, state) {
        final recipe = state.extra as Recipe;
        return RecipeDetailScreen(recipe: recipe);
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Error')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Page not found',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            state.uri.toString(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.goNamed(RouteNames.home),
            child: const Text('Go Home'),
          ),
        ],
      ),
    ),
  ),
);
