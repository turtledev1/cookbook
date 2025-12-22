import 'package:html/dom.dart';
import 'package:cookbook/domain/models/recipe.dart';

class HelloFreshNutritionParser {
  NutritionalInfo parse(Document document) {
    final bodyText = document.body?.text ?? '';
    
    int? calories;
    int? protein;
    int? carbs;
    int? fat;
    int? fiber;
    int? sodium;

    final caloriesMatch = RegExp(r'Calories(\d+)kcal', caseSensitive: false).firstMatch(bodyText);
    if (caloriesMatch != null) {
      calories = int.tryParse(caloriesMatch.group(1)!);
    }

    final proteinMatch = RegExp(r'Protein(\d+)g', caseSensitive: false).firstMatch(bodyText);
    if (proteinMatch != null) {
      protein = int.tryParse(proteinMatch.group(1)!);
    }

    final carbsMatch = RegExp(r'Carbohydrate(\d+)g', caseSensitive: false).firstMatch(bodyText);
    if (carbsMatch != null) {
      carbs = int.tryParse(carbsMatch.group(1)!);
    }

    final fatMatch = RegExp(r'Fat(\d+)g', caseSensitive: false).firstMatch(bodyText);
    if (fatMatch != null) {
      fat = int.tryParse(fatMatch.group(1)!);
    }

    final fiberMatch = RegExp(r'Dietary Fiber(\d+)g', caseSensitive: false).firstMatch(bodyText);
    if (fiberMatch != null) {
      fiber = int.tryParse(fiberMatch.group(1)!);
    }

    final sodiumMatch = RegExp(r'Sodium(\d+)mg', caseSensitive: false).firstMatch(bodyText);
    if (sodiumMatch != null) {
      sodium = int.tryParse(sodiumMatch.group(1)!);
    }

    return NutritionalInfo(
      calories: calories ?? 0,
      protein: protein ?? 0,
      carbs: carbs ?? 0,
      fat: fat ?? 0,
      fiber: fiber,
      sodium: sodium,
    );
  }
}
