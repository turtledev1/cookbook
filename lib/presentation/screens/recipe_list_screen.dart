import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cookbook/domain/models/search_filter.dart';
import 'package:cookbook/presentation/blocs/recipe_cubit.dart';
import 'package:cookbook/presentation/widgets/add_recipe_options_sheet.dart';
import 'package:cookbook/presentation/widgets/filter_options_sheet.dart';
import 'package:cookbook/presentation/widgets/empty_recipes_widget.dart';
import 'package:cookbook/presentation/widgets/recipe_list_view.dart';
import 'package:cookbook/presentation/widgets/recipe_search_bar.dart';

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
    showModalBottomSheet(context: context, builder: (context) => const AddRecipeOptionsSheet());
  }

  void _showFilterOptions(BuildContext context, RecipeCubit cubit) {
    showModalBottomSheet(
      context: context,
      builder: (context) => FilterOptionsSheet(
        currentFilter: _currentFilter,
        onFilterSelected: (value) {
          setState(() => _currentFilter = value);
          cubit.searchRecipes(_searchController.text, value);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeCubit, RecipeState>(
      builder: (context, state) {
        final cubit = context.read<RecipeCubit>();

        return Scaffold(
          appBar: AppBar(
            title: _isSearching
                ? RecipeSearchBar(
                    controller: _searchController,
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
                  return EmptyRecipesWidget(isSearching: _isSearching);
                }

                return RecipeListView(recipes: recipes);
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
    );
  }
}
