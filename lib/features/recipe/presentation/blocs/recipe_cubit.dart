import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../models/recipe.dart';
import '../../models/search_filter.dart';
import '../../repositories/recipe_repository.dart';

// States
abstract class RecipeState {}

class RecipeInitial extends RecipeState {}

class RecipeLoading extends RecipeState {}

class RecipeLoaded extends RecipeState {
  final List<Recipe> recipes;
  final List<Recipe> filteredRecipes;
  final String searchQuery;
  final SearchFilter searchFilter;

  RecipeLoaded(
    this.recipes, {
    List<Recipe>? filteredRecipes,
    this.searchQuery = '',
    this.searchFilter = SearchFilter.all,
  }) : filteredRecipes = filteredRecipes ?? recipes;

  List<Recipe> get displayRecipes => searchQuery.isEmpty ? recipes : filteredRecipes;
}

class RecipeError extends RecipeState {
  final String message;
  RecipeError(this.message);
}

// Cubit
@injectable
class RecipeCubit extends Cubit<RecipeState> {
  final RecipeRepository _repository;
  List<Recipe> _allRecipes = [];

  RecipeCubit(this._repository) : super(RecipeInitial());

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
              ) ?? false;
        case SearchFilter.all:
          final matchesName = recipe.name.toLowerCase().contains(lowerQuery);
          final matchesIngredients = recipe.ingredients.any(
            (ingredient) => ingredient.toLowerCase().contains(lowerQuery),
          );
          final matchesTags = recipe.tags?.any(
                (tag) => tag.toLowerCase().contains(lowerQuery),
              ) ?? false;
          return matchesName || matchesIngredients || matchesTags;
      }
    }).toList();

    emit(RecipeLoaded(
      _allRecipes,
      filteredRecipes: filtered,
      searchQuery: query,
      searchFilter: filter,
    ));
  }

  void clearSearch() {
    if (state is RecipeLoaded) {
      emit(RecipeLoaded(_allRecipes));
    }
  }
}
