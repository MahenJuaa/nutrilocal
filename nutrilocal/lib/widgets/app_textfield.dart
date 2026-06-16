import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class AppTextField
    extends StatelessWidget {

  final TextEditingController
      controller;

  final String hint;

  final bool obscureText;

  final TextInputType?
      keyboardType;

  const AppTextField({

    super.key,

    required this.controller,

    required this.hint,

    this.obscureText = false,

    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {

    return TextField(

      controller: controller,

      obscureText: obscureText,

      keyboardType:
          keyboardType,

      style: const TextStyle(
        color: AppColors.white,
      ),

      decoration: InputDecoration(

        hintText: hint,

        hintStyle:
            const TextStyle(
          color: Colors.white54,
        ),

        filled: true,

        fillColor:
            AppColors.card,

        contentPadding:
            const EdgeInsets.symmetric(

          horizontal: 20,

          vertical: 20,
        ),

        border:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(
                  20),

          borderSide:
              BorderSide.none,
        ),
      ),
    );
  }
}