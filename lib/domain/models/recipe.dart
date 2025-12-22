import 'package:json_annotation/json_annotation.dart';

part 'recipe.g.dart';

@JsonSerializable()
class Recipe {
  Recipe({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.steps,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    this.tags,
    required this.nutritionalInfo,
    this.allergens,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  final String id;
  final String name;
  final List<String> ingredients;
  final List<String> steps;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final List<String>? tags;
  final NutritionalInfo nutritionalInfo;
  final List<String>? allergens;

  int get totalTimeMinutes => prepTimeMinutes + cookTimeMinutes;
  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}

@JsonSerializable()
class NutritionalInfo {
  NutritionalInfo({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    this.fiber,
    this.sodium,
  });

  factory NutritionalInfo.fromJson(Map<String, dynamic> json) => _$NutritionalInfoFromJson(json);
  final int calories;
  final int protein; // grams
  final int carbs; // grams
  final int fat; // grams
  final int? fiber; // grams
  final int? sodium;
  Map<String, dynamic> toJson() => _$NutritionalInfoToJson(this);
}
