import 'package:flutter/material.dart';

class AppCard
    extends StatelessWidget {

  final Widget child;

  final EdgeInsets? padding;

  const AppCard({

    super.key,

    required this.child,

    this.padding,
  });

  @override
  Widget build(BuildContext context) {

    final isDark =
        Theme.of(context)
                .brightness ==
            Brightness.dark;

    return Container(

      padding:
          padding ??
              const EdgeInsets.all(
                  22),

      decoration:
          BoxDecoration(

        borderRadius:
            BorderRadius.circular(
                32),

        gradient: isDark

            ? LinearGradient(

                begin:
                    Alignment.topLeft,

                end:
                    Alignment.bottomRight,

                colors: [

                  const Color(
                      0xFF111827),

                  const Color(
                      0xFF0F172A),
                ],
              )

            : LinearGradient(

                begin:
                    Alignment.topLeft,

                end:
                    Alignment.bottomRight,

                colors: [

                  Colors.white,

                  const Color(
                      0xFFF8FAFC),
                ],
              ),

        border: Border.all(

          color: isDark

              ? Colors.white
                  .withOpacity(
                      0.05)

              : Colors.black
                  .withOpacity(
                      0.03),
        ),

        boxShadow: [

          BoxShadow(

            color: isDark

                ? const Color(
                        0xFF7C3AED)
                    .withOpacity(
                        0.12)

                : Colors.black
                    .withOpacity(
                        0.06),

            blurRadius: 30,

            offset:
                const Offset(
              0,
              12,
            ),
          ),
        ],
      ),

      child: child,
    );
  }
}