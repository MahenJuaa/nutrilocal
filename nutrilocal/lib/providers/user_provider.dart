import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class UserProvider
    extends ChangeNotifier {

  String username =
      'NutriLocal User';

  String bio =
      'AI Nutrition Tracker Enthusiast';

  UserProvider() {

    loadProfile();
  }

  Future<void> loadProfile()
  async {

    final prefs =
        await SharedPreferences
            .getInstance();

    username =
        prefs.getString(
              'username',
            ) ??
            'NutriLocal User';

    bio =
        prefs.getString(
              'bio',
            ) ??
            'AI Nutrition Tracker Enthusiast';

    notifyListeners();
  }

  Future<void> updateProfile({

    required String newUsername,

    required String newBio,

  }) async {

    username = newUsername;

    bio = newBio;

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setString(
      'username',
      username,
    );

    await prefs.setString(
      'bio',
      bio,
    );

    notifyListeners();
  }
}