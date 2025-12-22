import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:cookbook/app_config.dart';
import 'package:cookbook/domain/models/recipe.dart';
import 'package:cookbook/data/data_sources/recipe_data_source.dart';

@Injectable(as: RecipeDataSource)
class RecipeFirestoreDataSource implements RecipeDataSource {
  RecipeFirestoreDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  String get _collectionPath => AppConfig.recipesCollection;

  @override
  Future<List<Recipe>> getAllRecipes() async {
    try {
      final snapshot = await _firestore.collection(_collectionPath).orderBy('name').get();

      return snapshot.docs.map((doc) => Recipe.fromJson({...doc.data(), 'id': doc.id})).toList();
    } catch (e) {
      print('Error fetching recipes from Firestore: $e');
      return [];
    }
  }

  @override
  Future<Recipe?> getRecipeById(String id) async {
    try {
      final doc = await _firestore.collection(_collectionPath).doc(id).get();

      if (!doc.exists) return null;

      return Recipe.fromJson({...doc.data()!, 'id': doc.id});
    } catch (e) {
      print('Error fetching recipe from Firestore: $e');
      return null;
    }
  }

  @override
  Future<void> addRecipe(Recipe recipe) async {
    try {
      final data = recipe.toJson();
      data.remove('id'); // Don't store the ID in the document data

      await _firestore.collection(_collectionPath).doc(recipe.id).set(data);
    } catch (e) {
      print('Error adding recipe to Firestore: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateRecipe(Recipe recipe) async {
    try {
      final data = recipe.toJson();
      data.remove('id'); // Don't store the ID in the document data

      await _firestore.collection(_collectionPath).doc(recipe.id).update(data);
    } catch (e) {
      print('Error updating recipe in Firestore: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteRecipe(String id) async {
    try {
      await _firestore.collection(_collectionPath).doc(id).delete();
    } catch (e) {
      print('Error deleting recipe from Firestore: $e');
      rethrow;
    }
  }
}
