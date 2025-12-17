import 'package:injectable/injectable.dart';
import '../../domain/models/recipe.dart';
import 'recipe_data_source.dart';

@Named('firestore')
@Injectable(as: RecipeDataSource)
class RecipeFirestoreDataSource implements RecipeDataSource {
  // TODO: Add Cloud Firestore dependency
  // final FirebaseFirestore _firestore;
  
  // RecipeFirestoreDataSource(this._firestore);

  @override
  Future<List<Recipe>> getAllRecipes() async {
    // TODO: Implement Firestore query
    // final snapshot = await _firestore.collection('recipes').get();
    // return snapshot.docs.map((doc) => Recipe.fromJson(doc.data())).toList();
    
    throw UnimplementedError('Firestore data source not yet implemented');
  }

  @override
  Future<Recipe?> getRecipeById(String id) async {
    // TODO: Implement Firestore query
    // final doc = await _firestore.collection('recipes').doc(id).get();
    // return doc.exists ? Recipe.fromJson(doc.data()!) : null;
    
    throw UnimplementedError('Firestore data source not yet implemented');
  }

  @override
  Future<void> addRecipe(Recipe recipe) async {
    // TODO: Implement Firestore add
    // await _firestore.collection('recipes').doc(recipe.id).set(recipe.toJson());
    
    throw UnimplementedError('Firestore data source not yet implemented');
  }

  @override
  Future<void> updateRecipe(Recipe recipe) async {
    // TODO: Implement Firestore update
    // await _firestore.collection('recipes').doc(recipe.id).update(recipe.toJson());
    
    throw UnimplementedError('Firestore data source not yet implemented');
  }

  @override
  Future<void> deleteRecipe(String id) async {
    // TODO: Implement Firestore delete
    // await _firestore.collection('recipes').doc(id).delete();
    
    throw UnimplementedError('Firestore data source not yet implemented');
  }
}
