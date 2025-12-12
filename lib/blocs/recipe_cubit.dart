import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../models/recipe.dart';
import '../repositories/recipe_repository.dart';

// States
abstract class RecipeState {}

class RecipeInitial extends RecipeState {}

class RecipeLoading extends RecipeState {}

class RecipeLoaded extends RecipeState {
  final List<Recipe> recipes;
  RecipeLoaded(this.recipes);
}

class RecipeError extends RecipeState {
  final String message;
  RecipeError(this.message);
}

// Cubit
@injectable
class RecipeCubit extends Cubit<RecipeState> {
  final RecipeRepository _repository;

  RecipeCubit(this._repository) : super(RecipeInitial());

  Future<void> loadRecipes() async {
    emit(RecipeLoading());
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      final recipes = _repository.getAllRecipes();
      emit(RecipeLoaded(recipes));
    } catch (e) {
      emit(RecipeError(e.toString()));
    }
  }
}
