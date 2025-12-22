import 'package:injectable/injectable.dart';
import 'package:cookbook/domain/models/recipe.dart';
import 'package:cookbook/data/data_sources/recipe_data_source.dart';

@injectable
class RecipeRepository {
  RecipeRepository(this._dataSource);

  final RecipeDataSource _dataSource;

  Future<List<Recipe>> getAllRecipes() {
    return _dataSource.getAllRecipes();
  }

  Future<Recipe?> getRecipeById(String id) {
    return _dataSource.getRecipeById(id);
  }

  Future<void> addRecipe(Recipe recipe) {
    return _dataSource.addRecipe(recipe);
  }

  Future<void> updateRecipe(Recipe recipe) {
    return _dataSource.updateRecipe(recipe);
  }

  Future<void> deleteRecipe(String id) {
    return _dataSource.deleteRecipe(id);
  }
}
