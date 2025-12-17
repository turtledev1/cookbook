import 'package:injectable/injectable.dart';
import '../../domain/models/recipe.dart';
import 'recipe_data_source.dart';

@Named('local')
@Injectable(as: RecipeDataSource)
class RecipeLocalDataSource implements RecipeDataSource {
  final List<Recipe> _recipes = [
    Recipe(
      id: '1',
      name: 'Classic Spaghetti Carbonara',
      ingredients: [
        '400g spaghetti',
        '200g pancetta or guanciale, diced',
        '4 large eggs',
        '100g Pecorino Romano cheese, grated',
        '50g Parmesan cheese, grated',
        'Black pepper to taste',
        'Salt for pasta water',
      ],
      steps: [
        'Bring a large pot of salted water to boil and cook spaghetti according to package instructions',
        'While pasta cooks, fry pancetta in a large pan until crispy',
        'In a bowl, whisk together eggs, Pecorino, Parmesan, and black pepper',
        'Reserve 1 cup of pasta water, then drain pasta',
        'Remove pan from heat, add hot pasta to pancetta',
        'Quickly stir in egg mixture, adding pasta water as needed to create a creamy sauce',
        'Serve immediately with extra cheese and black pepper',
      ],
      prepTimeMinutes: 10,
      cookTimeMinutes: 15,
      tags: ['Italian', 'Pasta', 'Quick', 'Dinner'],
      nutritionalInfo: NutritionalInfo(calories: 650, protein: 28, carbs: 75, fat: 24, fiber: 3, sodium: 850),
      allergens: ['Eggs', 'Dairy', 'Gluten'],
    ),
    Recipe(
      id: '2',
      name: 'Chocolate Chip Cookies',
      ingredients: [
        '2 1/4 cups all-purpose flour',
        '1 tsp baking soda',
        '1 tsp salt',
        '1 cup butter, softened',
        '3/4 cup granulated sugar',
        '3/4 cup brown sugar',
        '2 large eggs',
        '2 tsp vanilla extract',
        '2 cups chocolate chips',
      ],
      steps: [
        'Preheat oven to 375°F (190°C)',
        'Mix flour, baking soda, and salt in a bowl',
        'In another bowl, cream butter and both sugars until fluffy',
        'Beat in eggs and vanilla',
        'Gradually blend in flour mixture',
        'Stir in chocolate chips',
        'Drop rounded tablespoons onto ungreased cookie sheets',
        'Bake 9-11 minutes or until golden brown',
      ],
      prepTimeMinutes: 15,
      cookTimeMinutes: 10,
      tags: ['Dessert', 'Baking', 'Cookies'],
      nutritionalInfo: NutritionalInfo(calories: 150, protein: 2, carbs: 19, fat: 8, fiber: 1, sodium: 85),
      allergens: ['Eggs', 'Dairy', 'Gluten'],
    ),
    Recipe(
      id: '3',
      name: 'Green Salad with Vinaigrette',
      ingredients: [
        '6 cups mixed greens',
        '1 cup cherry tomatoes, halved',
        '1 cucumber, sliced',
        '1/4 red onion, thinly sliced',
        '3 tbsp olive oil',
        '1 tbsp balsamic vinegar',
        '1 tsp Dijon mustard',
        'Salt and pepper to taste',
      ],
      steps: [
        'Wash and dry the mixed greens',
        'In a large bowl, combine greens, tomatoes, cucumber, and onion',
        'In a small bowl, whisk together olive oil, vinegar, mustard, salt, and pepper',
        'Drizzle dressing over salad just before serving',
        'Toss gently to coat',
      ],
      prepTimeMinutes: 10,
      cookTimeMinutes: 0,
      tags: ['Healthy', 'Vegetarian', 'Salad', 'Quick'],
      nutritionalInfo: NutritionalInfo(calories: 120, protein: 2, carbs: 8, fat: 10, fiber: 3, sodium: 150),
      allergens: null,
    ),
  ];

  @override
  Future<List<Recipe>> getAllRecipes() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(_recipes);
  }

  @override
  Future<Recipe?> getRecipeById(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      return _recipes.firstWhere((recipe) => recipe.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> addRecipe(Recipe recipe) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _recipes.add(recipe);
  }

  @override
  Future<void> updateRecipe(Recipe recipe) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final index = _recipes.indexWhere((r) => r.id == recipe.id);
    if (index != -1) {
      _recipes[index] = recipe;
    }
  }

  @override
  Future<void> deleteRecipe(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _recipes.removeWhere((recipe) => recipe.id == id);
  }
}
