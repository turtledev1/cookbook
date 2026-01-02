import 'package:cookbook/domain/models/recipe.dart';

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
