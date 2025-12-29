import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:cookbook/domain/models/recipe.dart';
import 'package:cookbook/domain/models/search_filter.dart';
import 'package:cookbook/domain/repositories/recipe_repository.dart';

// States
abstract class RecipeState {}

class RecipeInitial extends RecipeState {}

class RecipeLoading extends RecipeState {}

class RecipeLoaded extends RecipeState {
  RecipeLoaded(
    this.recipes, {
    List<Recipe>? filteredRecipes,
    this.searchQuery = '',
    this.searchFilter = SearchFilter.all,
  }) : filteredRecipes = filteredRecipes ?? recipes;

  final List<Recipe> recipes;
  final List<Recipe> filteredRecipes;
  final String searchQuery;
  final SearchFilter searchFilter;

  List<Recipe> get displayRecipes => searchQuery.isEmpty ? recipes : filteredRecipes;
}

class RecipeError extends RecipeState {
  RecipeError(this.message);
  final String message;
}

// Cubit
@injectable
class RecipeCubit extends Cubit<RecipeState> {
  RecipeCubit(this._repository) : super(RecipeInitial());
  final RecipeRepository _repository;
  List<Recipe> _allRecipes = [];

  Future<void> loadRecipes() async {
    emit(RecipeLoading());
    try {
      final recipes = await _repository.getAllRecipes();
      _allRecipes = recipes;
      emit(RecipeLoaded(recipes));
    } catch (e) {
      emit(RecipeError(e.toString()));
    }
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
      await _repository.updateRecipe(recipe);
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
