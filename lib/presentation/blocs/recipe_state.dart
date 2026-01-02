import 'package:cookbook/domain/models/recipe.dart';
import 'package:cookbook/domain/models/search_filter.dart';

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
