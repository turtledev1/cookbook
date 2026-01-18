import 'package:cookbook/presentation/blocs/recipe_state.dart';
import 'package:cookbook/presentation/blocs/settings_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:cookbook/domain/models/recipe.dart';
import 'package:cookbook/domain/models/search_filter.dart';
import 'package:cookbook/domain/repositories/recipe_repository.dart';

@injectable
class RecipeCubit extends Cubit<RecipeState> {
  RecipeCubit(this._repository, this._settingsCubit) : super(RecipeInitial());
  final RecipeRepository _repository;
  final SettingsCubit _settingsCubit;
  List<Recipe> _allRecipes = [];

  Future<void> loadRecipes() async {
    emit(RecipeLoading());
    try {
      final recipes = await _repository.getAllRecipes();
      _allRecipes = _sortRecipes(recipes);
      emit(RecipeLoaded(_allRecipes));
    } catch (e) {
      emit(RecipeError(e.toString()));
    }
  }

  List<Recipe> _sortRecipes(List<Recipe> recipes) {
    final sortOrder = _settingsCubit.state.sortOrder;
    final sorted = List<Recipe>.from(recipes);

    switch (sortOrder) {
      case SortOrder.alphabetical:
        sorted.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      case SortOrder.newest:
        sorted.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      case SortOrder.oldest:
        sorted.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }

    return sorted;
  }

  void searchRecipes(String query, SearchFilter filter) {
    if (state is! RecipeLoaded) return;

    if (query.isEmpty) {
      emit(RecipeLoaded(_allRecipes, searchQuery: '', searchFilter: filter));
      return;
    }

    final lowerQuery = query.toLowerCase();
    final filtered = _allRecipes.where((recipe) {
      switch (filter) {
        case SearchFilter.name:
          return recipe.name.toLowerCase().contains(lowerQuery);
        case SearchFilter.ingredients:
          return recipe.ingredients.any(
            (ingredient) => ingredient.toLowerCase().contains(lowerQuery),
          );
        case SearchFilter.tags:
          return recipe.tags?.any(
                (tag) => tag.toLowerCase().contains(lowerQuery),
              ) ??
              false;
        case SearchFilter.all:
          final matchesName = recipe.name.toLowerCase().contains(lowerQuery);
          final matchesIngredients = recipe.ingredients.any(
            (ingredient) => ingredient.toLowerCase().contains(lowerQuery),
          );
          final matchesTags =
              recipe.tags?.any(
                (tag) => tag.toLowerCase().contains(lowerQuery),
              ) ??
              false;
          return matchesName || matchesIngredients || matchesTags;
      }
    }).toList();

    emit(
      RecipeLoaded(
        _allRecipes,
        filteredRecipes: filtered,
        searchQuery: query,
        searchFilter: filter,
      ),
    );
  }

  void clearSearch() {
    if (state is RecipeLoaded) {
      emit(RecipeLoaded(_allRecipes));
    }
  }

  void applySortOrder() {
    if (state is RecipeLoaded) {
      _allRecipes = _sortRecipes(_allRecipes);
      emit(RecipeLoaded(_allRecipes));
    }
  }

  Future<void> addRecipe(Recipe recipe) async {
    try {
      await _repository.addRecipe(recipe);
      await loadRecipes(); // Reload all recipes after adding
    } catch (e) {
      emit(RecipeError('Failed to add recipe: ${e.toString()}'));
      rethrow;
    }
  }

  Future<void> updateRecipe(Recipe recipe) async {
    try {
      // Update the updatedAt timestamp
      final updatedRecipe = recipe.copyWith(updatedAt: DateTime.now());
      await _repository.updateRecipe(updatedRecipe);
      await loadRecipes(); // Reload all recipes after updating
    } catch (e) {
      emit(RecipeError('Failed to update recipe: ${e.toString()}'));
      rethrow;
    }
  }

  Future<void> deleteRecipe(String id) async {
    try {
      await _repository.deleteRecipe(id);
      await loadRecipes(); // Reload all recipes after deleting
    } catch (e) {
      emit(RecipeError('Failed to delete recipe: ${e.toString()}'));
      rethrow;
    }
  }
}
