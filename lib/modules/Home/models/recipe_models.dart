// ignore_for_file: constant_identifier_names

import 'dart:convert';

RecipeModels recipeModelsFromJson(String str) =>
    RecipeModels.fromJson(json.decode(str));

class RecipeModels {
  List<Recipe>? recipes;
  int? total;
  int? skip;
  int? limit;

  RecipeModels({this.recipes, this.total, this.skip, this.limit});

  factory RecipeModels.fromJson(Map<String, dynamic> json) => RecipeModels(
    recipes: List<Recipe>.from(json["recipes"].map((x) => Recipe.fromJson(x))),
    total: json["total"],
    skip: json["skip"],
    limit: json["limit"],
  );

  where(bool Function(dynamic recipe) param0) {}
}

class Recipe {
  int? id;
  String? name;
  List<String>? ingredients;
  List<String>? instructions;
  int? prepTimeMinutes;
  int? cookTimeMinutes;
  int? servings;
  Difficulty? difficulty;
  String? cuisine;
  int? caloriesPerServing;
  List<String>? tags;
  int? userId;
  String? image;
  double? rating;
  int? reviewCount;
  List<String>? mealType;

  Recipe({
    this.id,
    this.name,
    this.ingredients,
    this.instructions,
    this.prepTimeMinutes,
    this.cookTimeMinutes,
    this.servings,
    this.difficulty,
    this.cuisine,
    this.caloriesPerServing,
    this.tags,
    this.userId,
    this.image,
    this.rating,
    this.reviewCount,
    this.mealType,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    id: json["id"],
    name: json["name"],
    ingredients: List<String>.from(json["ingredients"].map((x) => x)),
    instructions: List<String>.from(json["instructions"].map((x) => x)),
    prepTimeMinutes: json["prepTimeMinutes"],
    cookTimeMinutes: json["cookTimeMinutes"],
    servings: json["servings"],
    difficulty: difficultyValues.map[json["difficulty"]],
    cuisine: json["cuisine"],
    caloriesPerServing: json["caloriesPerServing"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    userId: json["userId"],
    image: json["image"],
    rating: json["rating"].toDouble(),
    reviewCount: json["reviewCount"],
    mealType: List<String>.from(json["mealType"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "ingredients": List<dynamic>.from(ingredients!.map((x) => x)),
    "instructions": List<dynamic>.from(instructions!.map((x) => x)),
    "prepTimeMinutes": prepTimeMinutes,
    "cookTimeMinutes": cookTimeMinutes,
    "servings": servings,
    "difficulty": difficultyValues.reverse[difficulty],
    "cuisine": cuisine,
    "caloriesPerServing": caloriesPerServing,
    "tags": List<dynamic>.from(tags!.map((x) => x)),
    "userId": userId,
    "image": image,
    "rating": rating,
    "reviewCount": reviewCount,
    "mealType": List<dynamic>.from(mealType!.map((x) => x)),
  };
}

enum Difficulty { EASY, MEDIUM }

final difficultyValues = EnumValues({
  "Easy": Difficulty.EASY,
  "Medium": Difficulty.MEDIUM,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
