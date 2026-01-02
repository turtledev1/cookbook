import 'package:json_annotation/json_annotation.dart';

part 'recipe.g.dart';

enum RecipeDifficulty {
  @JsonValue('easy')
  easy,
  @JsonValue('medium')
  medium,
  @JsonValue('hard')
  hard,
}

@JsonSerializable(explicitToJson: true)
class Recipe {
  Recipe({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.steps,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    this.difficulty,
    this.tags,
    required this.nutritionalInfo,
    this.allergens,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  final String id;
  final String name;
  final List<String> ingredients;
  final List<String> steps;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final RecipeDifficulty? difficulty;
  final List<String>? tags;
  final NutritionalInfo nutritionalInfo;
  final List<String>? allergens;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  int get totalTimeMinutes => prepTimeMinutes + cookTimeMinutes;

  Map<String, dynamic> toJson() => _$RecipeToJson(this);

  Recipe copyWith({
    String? id,
    String? name,
    List<String>? ingredients,
    List<String>? steps,
    int? prepTimeMinutes,
    int? cookTimeMinutes,
    RecipeDifficulty? difficulty,
    List<String>? tags,
    NutritionalInfo? nutritionalInfo,
    List<String>? allergens,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      prepTimeMinutes: prepTimeMinutes ?? this.prepTimeMinutes,
      cookTimeMinutes: cookTimeMinutes ?? this.cookTimeMinutes,
      difficulty: difficulty ?? this.difficulty,
      tags: tags ?? this.tags,
      nutritionalInfo: nutritionalInfo ?? this.nutritionalInfo,
      allergens: allergens ?? this.allergens,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

@JsonSerializable()
class NutritionalInfo {
  NutritionalInfo({
    required this.calories,
    this.protein,
    this.carbs,
    this.fat,
    this.fiber,
    this.sodium,
  });

  factory NutritionalInfo.fromJson(Map<String, dynamic> json) => _$NutritionalInfoFromJson(json);
  final int calories;
  final int? protein; // grams
  final int? carbs; // grams
  final int? fat; // grams
  final int? fiber; // grams
  final int? sodium;
  Map<String, dynamic> toJson() => _$NutritionalInfoToJson(this);
}
