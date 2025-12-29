import 'package:html/dom.dart';
import 'package:cookbook/domain/models/recipe.dart';

class HelloFreshDifficultyParser {
  RecipeDifficulty? parse(Document document) {
    // Check for easy
    final easySpan = document.querySelector('span[data-translation-id="recipe-detail.level-number-1"]');
    if (easySpan != null) {
      return RecipeDifficulty.easy;
    }

    // Check for medium
    final mediumSpan = document.querySelector('span[data-translation-id="recipe-detail.level-number-2"]');
    if (mediumSpan != null) {
      return RecipeDifficulty.medium;
    }

    // Check for hard
    final hardSpan = document.querySelector('span[data-translation-id="recipe-detail.level-number-3"]');
    if (hardSpan != null) {
      return RecipeDifficulty.hard;
    }

    return null;
  }
}
