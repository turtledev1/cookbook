import 'package:html/dom.dart';

class HelloFreshIngredientsParser {
  List<String> parse(Document document) {
    final ingredients = <String>[];
    
    final ingredientItems = document.querySelectorAll('[data-test-id="ingredient-item-shipped"]');
    
    for (final item in ingredientItems) {
      final paragraphs = item.querySelectorAll('p');
      
      if (paragraphs.length >= 2) {
        final quantity = paragraphs[0].text.trim();
        final name = paragraphs[1].text.trim();
        
        if (name.isEmpty || name.length < 2) continue;
        
        final ingredient = '$quantity $name'.trim();
        
        if (ingredient.isNotEmpty && !ingredients.contains(ingredient)) {
          ingredients.add(ingredient);
        }
      }
    }

    return ingredients;
  }
}
