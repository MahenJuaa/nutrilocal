import 'package:flutter/material.dart';

class AppSnackbar {

  static void success(

    BuildContext context,

    String message,
  ) {

    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        backgroundColor:
            Colors.green,

        behavior:
            SnackBarBehavior.floating,

        shape:
            RoundedRectangleBorder(

          borderRadius:
              BorderRadius.circular(
                  16),
        ),

        content: Text(message),
      ),
    );
  }

  static void error(

    BuildContext context,

    String message,
  ) {

    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        backgroundColor:
            Colors.redAccent,

        behavior:
            SnackBarBehavior.floating,

        shape:
            RoundedRectangleBorder(

          borderRadius:
              BorderRadius.circular(
                  16),
        ),

        content: Text(message),
      ),
    );
  }

  static void info(

    BuildContext context,

    String message,
  ) {

    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        backgroundColor:
            const Color(
                0xFF7C3AED),

        behavior:
            SnackBarBehavior.floating,

        shape:
            RoundedRectangleBorder(

          borderRadius:
              BorderRadius.circular(
                  16),
        ),

        content: Text(message),
      ),
    );
  }
}