import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:cookbook/data/data_sources/parsers/hellofresh/hellofresh_parser.dart';
import 'package:cookbook/domain/models/recipe.dart';
import 'package:cookbook/domain/repositories/recipe_repository.dart';

// States
abstract class ImportRecipeState {}

class ImportRecipeInitial extends ImportRecipeState {}

class ImportRecipeLoading extends ImportRecipeState {}

class ImportRecipeParsed extends ImportRecipeState {
  ImportRecipeParsed(this.recipe);
  final Recipe recipe;
}

class ImportRecipeSaving extends ImportRecipeState {
  ImportRecipeSaving(this.recipe);
  final Recipe recipe;
}

class ImportRecipeSaved extends ImportRecipeState {}

class ImportRecipeError extends ImportRecipeState {
  ImportRecipeError(this.message);
  final String message;
}

@injectable
class ImportRecipeCubit extends Cubit<ImportRecipeState> {
  ImportRecipeCubit(this._repository, this._parser) : super(ImportRecipeInitial());

  final RecipeRepository _repository;
  final HelloFreshParser _parser;

  Future<void> parseRecipe(String url) async {
    if (url.isEmpty) {
      emit(ImportRecipeError('Please enter a URL'));
      return;
    }

    if (!url.contains('hellofresh.ca/recipes/')) {
      emit(ImportRecipeError('Only HelloFresh CA recipes are supported'));
      return;
    }

    emit(ImportRecipeLoading());

    try {
      final recipe = await _parser.parseRecipeFromUrl(url);
      if (recipe == null) {
        emit(ImportRecipeError('Failed to parse recipe'));
      } else {
        emit(ImportRecipeParsed(recipe));
      }
    } catch (e) {
      emit(ImportRecipeError('Error: $e'));
    }
  }

  Future<void> saveRecipe(Recipe recipe) async {
    emit(ImportRecipeSaving(recipe));

    try {
      // Check if a recipe with the same name already exists
      final existingRecipes = await _repository.getAllRecipes();
      final duplicateName = existingRecipes.any(
        (existing) => existing.name.toLowerCase() == recipe.name.toLowerCase(),
      );

      if (duplicateName) {
        emit(ImportRecipeError('A recipe with the name "${recipe.name}" already exists'));
        return;
      }

      await _repository.addRecipe(recipe);
      emit(ImportRecipeSaved());
    } catch (e) {
      emit(ImportRecipeError('Failed to save recipe: $e'));
    }
  }

  void reset() {
    emit(ImportRecipeInitial());
  }
}
