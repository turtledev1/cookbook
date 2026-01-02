// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
  id: json['id'] as String,
  name: json['name'] as String,
  ingredients: (json['ingredients'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  steps: (json['steps'] as List<dynamic>).map((e) => e as String).toList(),
  prepTimeMinutes: (json['prepTimeMinutes'] as num).toInt(),
  cookTimeMinutes: (json['cookTimeMinutes'] as num).toInt(),
  difficulty: $enumDecodeNullable(
    _$RecipeDifficultyEnumMap,
    json['difficulty'],
  ),
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  nutritionalInfo: NutritionalInfo.fromJson(
    json['nutritionalInfo'] as Map<String, dynamic>,
  ),
  allergens: (json['allergens'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  imageUrl: json['imageUrl'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'ingredients': instance.ingredients,
  'steps': instance.steps,
  'prepTimeMinutes': instance.prepTimeMinutes,
  'cookTimeMinutes': instance.cookTimeMinutes,
  'difficulty': _$RecipeDifficultyEnumMap[instance.difficulty],
  'tags': instance.tags,
  'nutritionalInfo': instance.nutritionalInfo.toJson(),
  'allergens': instance.allergens,
  'imageUrl': instance.imageUrl,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$RecipeDifficultyEnumMap = {
  RecipeDifficulty.easy: 'easy',
  RecipeDifficulty.medium: 'medium',
  RecipeDifficulty.hard: 'hard',
};

NutritionalInfo _$NutritionalInfoFromJson(Map<String, dynamic> json) =>
    NutritionalInfo(
      calories: (json['calories'] as num).toInt(),
      protein: (json['protein'] as num?)?.toInt(),
      carbs: (json['carbs'] as num?)?.toInt(),
      fat: (json['fat'] as num?)?.toInt(),
      fiber: (json['fiber'] as num?)?.toInt(),
      sodium: (json['sodium'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NutritionalInfoToJson(NutritionalInfo instance) =>
    <String, dynamic>{
      'calories': instance.calories,
      'protein': instance.protein,
      'carbs': instance.carbs,
      'fat': instance.fat,
      'fiber': instance.fiber,
      'sodium': instance.sodium,
    };
