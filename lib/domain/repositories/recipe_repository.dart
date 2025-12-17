import 'package:injectable/injectable.dart';
import '../models/recipe.dart';
import '../../data/data_sources/recipe_data_source.dart';

@injectable
class RecipeRepository {
  final RecipeDataSource _dataSource;

  // Change @Named('local') to @Named('firestore') to switch data sources
  RecipeRepository(@Named('local') this._dataSource);

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
