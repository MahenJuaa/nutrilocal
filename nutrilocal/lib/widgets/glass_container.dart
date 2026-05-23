import 'dart:ui';

import 'package:flutter/material.dart';

class GlassContainer
    extends StatelessWidget {

  final Widget child;

  final EdgeInsets? padding;

  final BorderRadius?
      borderRadius;

  const GlassContainer({

    super.key,

    required this.child,

    this.padding,

    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {

    final isDark =
        Theme.of(context)
                .brightness ==
            Brightness.dark;

    return ClipRRect(

      borderRadius:
          borderRadius ??
              BorderRadius.circular(
                  32),

      child: BackdropFilter(

        filter: ImageFilter.blur(

          sigmaX: 18,

          sigmaY: 18,
        ),

        child: Container(

          padding:
              padding ??
                  const EdgeInsets.all(
                      24),

          decoration:
              BoxDecoration(

            borderRadius:
                borderRadius ??
                    BorderRadius.circular(
                        32),

            color: isDark

                ? Colors.white
                    .withOpacity(
                        0.06)

                : Colors.white
                    .withOpacity(
                        0.65),

            border: Border.all(

              color: isDark

                  ? Colors.white
                      .withOpacity(
                          0.08)

                  : Colors.white
                      .withOpacity(
                          0.35),
            ),

            boxShadow: [

              BoxShadow(

                color:
                    Colors.black
                        .withOpacity(
                  0.08,
                ),

                blurRadius:
                    24,

                offset:
                    const Offset(
                  0,
                  12,
                ),
              ),
            ],
          ),

          child: child,
        ),
      ),
    );
  }
}