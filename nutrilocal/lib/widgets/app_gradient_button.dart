import 'package:flutter/material.dart';

class AppGradientButton
    extends StatelessWidget {

  final String text;

  final VoidCallback onTap;

  const AppGradientButton({

    super.key,

    required this.text,

    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        width: double.infinity,

        padding:
            const EdgeInsets.symmetric(

          vertical: 18,
        ),

        decoration: BoxDecoration(

          borderRadius:
              BorderRadius.circular(
                  20),

          gradient:
              const LinearGradient(
            colors: [

              Color(0xFF7C3AED),

              Color(0xFF06B6D4),
            ],
          ),
        ),

        child: Center(

          child: Text(

            text,

            style: const TextStyle(

              color: Colors.white,

              fontSize: 16,

              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}