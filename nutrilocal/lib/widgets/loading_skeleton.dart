import 'package:flutter/material.dart';

class LoadingSkeleton
    extends StatefulWidget {

  final double height;

  final double? width;

  final BorderRadius?
      borderRadius;

  const LoadingSkeleton({

    super.key,

    required this.height,

    this.width,

    this.borderRadius,
  });

  @override
  State<LoadingSkeleton>
      createState() =>
          _LoadingSkeletonState();
}

class _LoadingSkeletonState
    extends State<
        LoadingSkeleton>
    with
        SingleTickerProviderStateMixin {

  late AnimationController
      controller;

  @override
  void initState() {

    super.initState();

    controller =
        AnimationController(

      vsync: this,

      duration:
          const Duration(
        milliseconds: 1400,
      ),
    )..repeat();
  }

  @override
  void dispose() {

    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final isDark =
        Theme.of(context)
                .brightness ==
            Brightness.dark;

    return AnimatedBuilder(

      animation: controller,

      builder:
          (_, child) {

        return Container(

          width:
              widget.width,

          height:
              widget.height,

          decoration:
              BoxDecoration(

            borderRadius:
                widget.borderRadius ??
                    BorderRadius.circular(
                        18),

            gradient:
                LinearGradient(

              begin:
                  Alignment(
                -1 +
                    controller
                        .value *
                        2,
                0,
              ),

              end:
                  Alignment(
                1 +
                    controller
                        .value *
                        2,
                0,
              ),

              colors: isDark

                  ? [

                      const Color(
                          0xFF111827),

                      const Color(
                          0xFF1E293B),

                      const Color(
                          0xFF111827),
                    ]

                  : [

                      const Color(
                          0xFFE5E7EB),

                      Colors.white,

                      const Color(
                          0xFFE5E7EB),
                    ],
            ),
          ),
        );
      },
    );
  }
}