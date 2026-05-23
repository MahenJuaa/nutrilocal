import 'package:flutter/material.dart';

class PageTransition
    extends PageRouteBuilder {

  final Widget page;

  PageTransition({
    required this.page,
  })

      : super(

          transitionDuration:
              const Duration(
            milliseconds: 350,
          ),

          reverseTransitionDuration:
              const Duration(
            milliseconds: 300,
          ),

          pageBuilder:

              (
                context,
                animation,
                secondaryAnimation,
              ) {

            return page;
          },

          transitionsBuilder:

              (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {

            const begin =
                Offset(
              0.08,
              0,
            );

            const end =
                Offset.zero;

            const curve =
                Curves.easeOutCubic;

            final tween =
                Tween(

              begin: begin,
              end: end,

            ).chain(

              CurveTween(
                curve: curve,
              ),
            );

            return FadeTransition(

              opacity: animation,

              child:
                  SlideTransition(

                position:
                    animation
                        .drive(
                            tween),

                child: child,
              ),
            );
          },
        );
}