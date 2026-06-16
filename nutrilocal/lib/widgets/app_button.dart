import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class AppButton
    extends StatelessWidget {

  final String text;

  final VoidCallback? onTap;

  final bool isLoading;

  const AppButton({

    super.key,

    required this.text,

    required this.onTap,

    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(

      width: double.infinity,

      child: ElevatedButton(

        onPressed:

            isLoading

                ? null

                : onTap,

        style:
            ElevatedButton.styleFrom(

          backgroundColor:
              AppColors.primary,

          padding:
              const EdgeInsets.symmetric(
            vertical: 18,
          ),

          shape:
              RoundedRectangleBorder(

            borderRadius:
                BorderRadius.circular(
                    20),
          ),
        ),

        child:

            isLoading

                ? const SizedBox(

                    width: 24,
                    height: 24,

                    child:
                        CircularProgressIndicator(

                      color:
                          Colors.white,

                      strokeWidth: 2,
                    ),
                  )

                : Text(

                    text,

                    style:
                        const TextStyle(
                      fontSize: 16,
                    ),
                  ),
      ),
    );
  }
}