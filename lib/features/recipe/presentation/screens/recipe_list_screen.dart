import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../injection.dart';
import '../../../../router_names.dart';
import '../../models/search_filter.dart';
import '../blocs/recipe_cubit.dart';
import '../widgets/recipe_card.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  SearchFilter _currentFilter = SearchFilter.all;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showAddRecipeOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.create),
              title: const Text('Create from Scratch'),
              subtitle: const Text('Manually enter recipe details'),
              onTap: () {
                Navigator.pop(context);
                context.pushNamed(RouteNames.createRecipe);
              },
            ),
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('Import from Website'),
              subtitle: const Text('Parse recipe from a URL'),
              onTap: () {
                Navigator.pop(context);
                context.pushNamed(RouteNames.importRecipe);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterOptions(BuildContext context, RecipeCubit cubit) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Search Filter',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ...SearchFilter.values.map((filter) {
              return RadioListTile<SearchFilter>(
                title: Text(filter.label),
                value: filter,
                groupValue: _currentFilter,
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _currentFilter = value);
                    cubit.searchRecipes(_searchController.text, value);
                    Navigator.pop(context);
                  }
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RecipeCubit>()..loadRecipes(),
      child: BlocBuilder<RecipeCubit, RecipeState>(
        builder: (context, state) {
          final cubit = context.read<RecipeCubit>();

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: _isSearching
                  ? TextField(
                      controller: _searchController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'Search recipes...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.white70),
                      ),
                      style: const TextStyle(color: Colors.white),
                      onChanged: (query) {
                        cubit.searchRecipes(query, _currentFilter);
                      },
                    )
                  : const Text('My Cookbook'),
              actions: [
                if (_isSearching)
                  IconButton(
                    icon: const Icon(Icons.filter_list),
                    tooltip: 'Filter (${_currentFilter.label})',
                    onPressed: () => _showFilterOptions(context, cubit),
                  ),
                IconButton(
                  icon: Icon(_isSearching ? Icons.close : Icons.search),
                  onPressed: () {
                    setState(() {
                      _isSearching = !_isSearching;
                      if (!_isSearching) {
                        _searchController.clear();
                        _currentFilter = SearchFilter.all;
                        cubit.clearSearch();
                      }
                    });
                  },
                ),
              ],
            ),
            body: Builder(
              builder: (context) {
                if (state is RecipeLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is RecipeError) {
                  return Center(child: Text('Error: ${state.message}'));
                }

                if (state is RecipeLoaded) {
                  final recipes = state.displayRecipes;

                  if (recipes.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _isSearching ? Icons.search_off : Icons.restaurant_menu,
                            size: 64,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _isSearching ? 'No recipes found' : 'No recipes yet',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          if (_isSearching) ...[
                            const SizedBox(height: 8),
                            Text(
                              'Try a different search term or filter',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                          ],
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = recipes[index];
                      return RecipeCard(recipe: recipe);
                    },
                  );
                }

                return const Center(child: Text('No recipes found'));
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _showAddRecipeOptions(context),
              tooltip: 'Add Recipe',
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
