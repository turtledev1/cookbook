import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cookbook/domain/models/recipe.dart';
import 'package:cookbook/router_names.dart';
import 'package:cookbook/presentation/widgets/recipe_detail/recipe_time_and_difficulty_row.dart';
import 'package:cookbook/presentation/widgets/recipe_detail/recipe_tags_section.dart';
import 'package:cookbook/presentation/widgets/recipe_detail/nutritional_info_section.dart';
import 'package:cookbook/presentation/widgets/recipe_detail/allergens_section.dart';
import 'package:cookbook/presentation/widgets/recipe_detail/ingredients_section.dart';
import 'package:cookbook/presentation/widgets/recipe_detail/steps_section.dart';

class RecipeDetailScreen extends StatefulWidget {
  const RecipeDetailScreen({super.key, required this.recipe});

  final Recipe recipe;

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  context.pushNamed(
                    RouteNames.recipeForm,
                    extra: widget.recipe,
                  );
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'recipe-image-${widget.recipe.id}',
                child: widget.recipe.imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: widget.recipe.imageUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[300],
                          child: const Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(Icons.restaurant, size: 64, color: Colors.grey),
                          ),
                        ),
                      )
                    : Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.restaurant, size: 64, color: Colors.grey),
                        ),
                      ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    widget.recipe.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Time and Difficulty Row
                  RecipeTimeAndDifficultyRow(
                    prepTimeMinutes: widget.recipe.prepTimeMinutes,
                    cookTimeMinutes: widget.recipe.cookTimeMinutes,
                    difficulty: widget.recipe.difficulty,
                  ),
                  const SizedBox(height: 24),

                  // Tags
                  RecipeTagsSection(tags: widget.recipe.tags),

                  // Nutritional Info
                  NutritionalInfoSection(
                    nutritionalInfo: widget.recipe.nutritionalInfo,
                  ),

                  // Allergens
                  AllergensSection(allergens: widget.recipe.allergens),

                  // Ingredients
                  IngredientsSection(ingredients: widget.recipe.ingredients),

                  // Steps
                  StepsSection(steps: widget.recipe.steps),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
