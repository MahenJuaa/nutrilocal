import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart'
    as http;

import '../core/api_state.dart';

import 'package:image_picker/image_picker.dart';

class ApiService {

  static const String baseUrl =
      'http://192.168.137.1:8000';

  static Future<ApiState<dynamic>>
      login({

    required String email,

    required String password,

  }) async {

    try {

      final response =
          await http.post(

        Uri.parse(
          '$baseUrl/login',
        ),

        headers: {

          'Content-Type':
              'application/json',
        },

        body: jsonEncode({

          'email': email,

          'password': password,
        }),
      );

      if (response.statusCode ==
          200) {

        final data =
            jsonDecode(
          response.body,
        );

        return ApiState.success(
          data,
        );
      }

      return ApiState.error(

        'Invalid email or password',
      );
    }

    catch (e) {

      return ApiState.error(

        'Connection failed',
      );
    }
  }

  static Future<ApiState<dynamic>>
      register({

    required String email,

    required String password,

  }) async {

    try {

      final response =
          await http.post(

        Uri.parse(
          '$baseUrl/register',
        ),

        headers: {

          'Content-Type':
              'application/json',
        },

        body: jsonEncode({

          'email': email,

          'password': password,
        }),
      );

      if (response.statusCode ==
          200) {

        final data =
            jsonDecode(
          response.body,
        );

        return ApiState.success(
          data,
        );
      }

      return ApiState.error(

        'Registration failed',
      );
    }

    catch (e) {

      return ApiState.error(

        'Connection failed',
      );
    }
  }

  static Future<ApiState<List<dynamic>>>
      getFoods() async {

    try {

      final response =
          await http.get(

        Uri.parse(
          '$baseUrl/api/foods',
        ),
      );

      if (response.statusCode ==
          200) {

        final data =
            jsonDecode(
          response.body,
        );

        return ApiState.success(

          List<dynamic>.from(
              data),
        );
      }

      return ApiState.error(
        'Failed to load foods',
      );
    }

    catch (e) {

      return ApiState.error(
        'Connection failed',
      );
    }
  }

  static Future<ApiState<dynamic>>
      searchFood({

    required String foodName,

  }) async {

    try {

      final response =
          await http.get(

        Uri.parse(
          '$baseUrl/api/foods/search/$foodName',
        ),
      );

      if (response.statusCode ==
          200) {

        final data =
            jsonDecode(
          response.body,
        );

        return ApiState.success(
          data,
        );
      }

      return ApiState.error(

        'Food not found',
      );
    }

    catch (e) {

      return ApiState.error(

        'Connection failed',
      );
    }
  }

  static Future<ApiState<dynamic>>
      addMeal({

    required String userEmail,

    required String foodName,

    required int calories,

  }) async {

    try {

      final response =
          await http.post(

        Uri.parse(
          '$baseUrl/log-food',
        ),

        headers: {

          'Content-Type':
              'application/json',
        },

        body: jsonEncode({

          'user_email':
              userEmail,

          'food_name':
              foodName,

          'calories':
              calories,
        }),
      );

      if (response.statusCode ==
          200) {

        final data =
            jsonDecode(
          response.body,
        );

        return ApiState.success(
          data,
        );
      }

      return ApiState.error(
        'Failed to add meal',
      );
    }

    catch (e) {

      return ApiState.error(
        'Connection failed',
      );
    }
  }

  static Future<ApiState<dynamic>>
      scanFoodImage({

    required XFile imageFile,

  }) async {

    try {

      var request =
          http.MultipartRequest(

        'POST',

        Uri.parse(
          '$baseUrl/api/scan-food',
        ),
      );

      // Gunakan readAsBytes() agar aman dikirim via Web maupun Mobile
      final bytes =
          await imageFile.readAsBytes();

      request.files.add(

        http.MultipartFile.fromBytes(

          'image',

          bytes,

          filename:
              imageFile.name,
        ),
      );

      var streamedResponse =
          await request.send();

      var response =
          await http.Response.fromStream(
        streamedResponse,
      );

      if (response.statusCode ==
          200) {

        final data =
            jsonDecode(
          response.body,
        );

        return ApiState.success(
          data,
        );
      }

      return ApiState.error(

        'Failed to scan food',
      );
    }

    catch (e) {

      return ApiState.error(

        'Connection failed',
      );
    }
  }
}