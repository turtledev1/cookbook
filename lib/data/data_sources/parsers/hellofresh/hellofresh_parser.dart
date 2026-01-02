import 'package:html/parser.dart' as html_parser;
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'package:cookbook/domain/models/recipe.dart';
import 'package:cookbook/data/data_sources/parsers/hellofresh/hellofresh_name_parser.dart';
import 'package:cookbook/data/data_sources/parsers/hellofresh/hellofresh_time_parser.dart';
import 'package:cookbook/data/data_sources/parsers/hellofresh/hellofresh_ingredients_parser.dart';
import 'package:cookbook/data/data_sources/parsers/hellofresh/hellofresh_steps_parser.dart';
import 'package:cookbook/data/data_sources/parsers/hellofresh/hellofresh_nutrition_parser.dart';
import 'package:cookbook/data/data_sources/parsers/hellofresh/hellofresh_allergens_parser.dart';
import 'package:cookbook/data/data_sources/parsers/hellofresh/hellofresh_tags_parser.dart';
import 'package:cookbook/data/data_sources/parsers/hellofresh/hellofresh_difficulty_parser.dart';

@injectable
class HelloFreshParser {
  final _nameParser = HelloFreshNameParser();
  final _timeParser = HelloFreshTimeParser();
  final _ingredientsParser = HelloFreshIngredientsParser();
  final _stepsParser = HelloFreshStepsParser();
  final _nutritionParser = HelloFreshNutritionParser();
  final _allergensParser = HelloFreshAllergensParser();
  final _tagsParser = HelloFreshTagsParser();
  final _difficultyParser = HelloFreshDifficultyParser();
  final _uuid = const Uuid();

  Future<Recipe?> parseRecipeFromUrl(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        return null;
      }

      final document = html_parser.parse(response.body);

      final name = _nameParser.parse(document);
      final prepTime = _timeParser.parsePreparationTime(document);
      final cookTime = _timeParser.parseCookingTime(document);
      final ingredients = _ingredientsParser.parse(document);
      final steps = _stepsParser.parse(document);
      final nutritionalInfo = _nutritionParser.parse(document);
      final allergens = _allergensParser.parse(document);
      final tags = _tagsParser.parse(document);
      final difficulty = _difficultyParser.parse(document);

      final now = DateTime.now();
      return Recipe(
        id: _uuid.v4(),
        name: name,
        ingredients: ingredients,
        steps: steps,
        prepTimeMinutes: prepTime,
        cookTimeMinutes: cookTime,
        difficulty: difficulty,
        nutritionalInfo: nutritionalInfo,
        allergens: allergens.isNotEmpty ? allergens : null,
        tags: tags.isNotEmpty ? tags : null,
        createdAt: now,
        updatedAt: now,
      );
    } catch (e, _) {
      return null;
    }
  }
}
