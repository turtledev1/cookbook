import 'package:cookbook/presentation/blocs/import_recipe_state.dart';
import 'package:cookbook/router_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cookbook/injection.dart';
import 'package:cookbook/presentation/blocs/import_recipe_cubit.dart';
import 'package:cookbook/presentation/blocs/recipe_cubit.dart';
import 'package:cookbook/presentation/widgets/import/recipe_preview_card.dart';

class ImportRecipeScreen extends StatefulWidget {
  const ImportRecipeScreen({super.key});

  @override
  State<ImportRecipeScreen> createState() => _ImportRecipeScreenState();
}

class _ImportRecipeScreenState extends State<ImportRecipeScreen> {
  final _urlController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ImportRecipeCubit>(),
      child: BlocListener<ImportRecipeCubit, ImportRecipeState>(
        listener: (context, state) {
          if (state is ImportRecipeSaved) {
            // Reload recipes in the main cubit
            context.read<RecipeCubit>().loadRecipes();
            
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Recipe saved successfully!'),
              ),
            );
            context.pop();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Import Recipe'),
          ),
          body: SafeArea(
            child: BlocBuilder<ImportRecipeCubit, ImportRecipeState>(
              builder: (context, state) {
                final cubit = context.read<ImportRecipeCubit>();
            
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: _urlController,
                        decoration: const InputDecoration(
                          labelText: 'HelloFresh Recipe URL',
                          hintText: 'https://www.hellofresh.ca/recipes/...',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton(
                        onPressed: state is ImportRecipeLoading
                            ? null
                            : () => cubit.parseRecipe(_urlController.text.trim()),
                        child: state is ImportRecipeLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('Parse Recipe'),
                      ),
                      if (state is ImportRecipeError) ...[
                        const SizedBox(height: 16),
                        Card(
                          color: Colors.red.shade50,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              state.message,
                              style: TextStyle(color: Colors.red.shade900),
                            ),
                          ),
                        ),
                      ],
                      if (state is ImportRecipeParsed || state is ImportRecipeSaving) ...[
                        const SizedBox(height: 24),
                        const Text(
                          'Parsed Recipe:',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: FilledButton.icon(
                                onPressed: state is ImportRecipeSaving
                                    ? null
                                    : () {
                                        final recipe = state is ImportRecipeParsed
                                            ? state.recipe
                                            : (state as ImportRecipeSaving).recipe;
                                        cubit.saveRecipe(recipe);
                                      },
                                icon: state is ImportRecipeSaving
                                    ? const SizedBox(
                                        height: 16,
                                        width: 16,
                                        child: CircularProgressIndicator(strokeWidth: 2),
                                      )
                                    : const Icon(Icons.save),
                                label: const Text('Save Recipe'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton.outlined(
                              onPressed: state is ImportRecipeSaving
                                  ? null
                                  : () {
                                      final recipe = state is ImportRecipeParsed
                                          ? state.recipe
                                          : (state as ImportRecipeSaving).recipe;
                                      context.pushNamed(
                                        RouteNames.recipeForm,
                                        extra: recipe,
                                      );
                                    },
                              icon: const Icon(Icons.edit),
                              tooltip: 'Edit recipe',
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        RecipePreviewCard(
                          recipe: state is ImportRecipeParsed
                              ? state.recipe
                              : (state as ImportRecipeSaving).recipe,
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
