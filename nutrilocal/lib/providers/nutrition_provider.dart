import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Meal {

  final String name;

  final int calories;

  Meal({

    required this.name,

    required this.calories,
  });

  Map<String, dynamic>
      toJson() {

    return {

      'name': name,

      'calories':
          calories,
    };
  }

  factory Meal.fromJson(
    Map<String, dynamic>
        json,
  ) {

    return Meal(

      name:
          json['name'],

      calories:
          json['calories'],
    );
  }
}

class NutritionProvider
    extends ChangeNotifier {

  final List<Meal> _meals =
      [];

  int _waterIntake = 0;

  int _calorieGoal =
      2000;

  int _streakDays = 7;

  List<Meal> get meals =>
      _meals;

  int get waterIntake =>
      _waterIntake;

  int get calorieGoal =>
      _calorieGoal;

  int get streakDays =>
      _streakDays;

  int get totalCalories {

    int total = 0;

    for (var meal
        in _meals) {

      total +=
          meal.calories;
    }

    return total;
  }

  int get totalMeals =>
      _meals.length;

  int get averageCalories {

    if (_meals.isEmpty) {
      return 0;
    }

    return (totalCalories /
            _meals.length)
        .round();
  }

  int get hydrationPercentage {

    return ((_waterIntake /
                2000) *
            100)
        .clamp(
          0,
          100,
        )
        .round();
  }

  String get aiInsight {

    if (_meals.isEmpty) {

      return 'Start tracking your meals to receive personalized AI nutrition insights and healthier recommendations.';
    }

    if (totalCalories <
        1200) {

      return 'Your calorie intake is still low today. Consider adding balanced meals with protein and healthy carbohydrates.';
    }

    if (totalCalories >
        2500) {

      return 'Your calorie intake is relatively high today. Try balancing meals with vegetables and hydration.';
    }

    if (_waterIntake <
        1000) {

      return 'Your hydration level is still low. Drink more water to maintain focus and body performance.';
    }

    return 'Great job! Your nutrition tracking looks balanced today. Keep maintaining healthy eating habits.';
  }

  NutritionProvider() {

    loadData();
  }

  Future<void> addMeal(

    String name,

    int calories,

  ) async {

    _meals.add(

      Meal(

        name: name,

        calories:
            calories,
      ),
    );

    notifyListeners();

    await saveData();
  }

  Future<void>
      deleteMeal(
    int index,
  ) async {

    _meals.removeAt(
        index);

    notifyListeners();

    await saveData();
  }

  Future<void>
      addWater(
    int amount,
  ) async {

    _waterIntake +=
        amount;

    notifyListeners();

    await saveData();
  }

  Future<void>
      resetWater() async {

    _waterIntake = 0;

    notifyListeners();

    await saveData();
  }

  Future<void>
      saveData() async {

    final prefs =
        await SharedPreferences
            .getInstance();

    final mealsJson =
        _meals
            .map(
              (meal) =>
                  jsonEncode(
                meal.toJson(),
              ),
            )
            .toList();

    await prefs.setStringList(
      'meals',
      mealsJson,
    );

    await prefs.setInt(

      'waterIntake',

      _waterIntake,
    );
  }

  Future<void>
      loadData() async {

    final prefs =
        await SharedPreferences
            .getInstance();

    final mealsJson =
        prefs.getStringList(
              'meals',
            ) ??
            [];

    _meals.clear();

    for (var item
        in mealsJson) {

      _meals.add(

        Meal.fromJson(

          jsonDecode(
            item,
          ),
        ),
      );
    }

    _waterIntake =
        prefs.getInt(
              'waterIntake',
            ) ??
            0;

    notifyListeners();
  }
}