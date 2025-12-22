import 'package:html/dom.dart';

class HelloFreshAllergensParser {
  List<String> parse(Document document) {
    final allergens = <String>[];
    
    final allergenElements = document.querySelectorAll('[data-test-id="recipe-description-allergen"]');
    
    for (final allergenElement in allergenElements) {
      final spans = allergenElement.querySelectorAll('span');
      
      if (spans.isNotEmpty) {
        final allergen = spans.last.text.trim();
        
        if (allergen.isNotEmpty && !allergens.contains(allergen)) {
          allergens.add(allergen);
        }
      }
    }

    return allergens;
  }
}
