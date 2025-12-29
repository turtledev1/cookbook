import 'package:html/dom.dart';
import 'package:cookbook/domain/models/recipe.dart';

class HelloFreshNutritionParser {
  NutritionalInfo parse(Document document) {
    final nutritionDivs = document.querySelectorAll('div[data-test-id="nutrition-step"]');
    
    int? calories;
    int? protein;
    int? carbs;
    int? fat;
    int? fiber;
    int? sodium;

    for (final div in nutritionDivs) {
      final spans = div.querySelectorAll('span');
      if (spans.length >= 2) {
        final label = spans[0].text.toLowerCase().trim();
        final valueText = spans[1].text.trim();
        final value = int.tryParse(RegExp(r'(\d+)').firstMatch(valueText)?.group(1) ?? '');
        
        if (value == null) continue;
        
        // Match English and French labels
        if (label.contains('calories') || label.contains('énergie')) {
          calories = value;
        } else if (label == 'protein' || label == 'protéines') {
          protein = value;
        } else if (label == 'carbohydrate' || label == 'glucides') {
          carbs = value;
        } else if (label == 'fat' || label == 'graisses') {
          fat = value;
        } else if (label.contains('fiber') || label == 'fibres') {
          fiber = value;
        } else if (label == 'sodium' || label == 'sel') {
          sodium = value;
        }
      }
    }

    return NutritionalInfo(
      calories: calories ?? 0,
      protein: protein,
      carbs: carbs,
      fat: fat,
      fiber: fiber,
      sodium: sodium,
    );
  }
}
