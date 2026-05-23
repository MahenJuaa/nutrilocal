import 'package:flutter/material.dart';

import 'app_card.dart';

class AnimatedStatCard
    extends StatefulWidget {

  final String title;

  final String value;

  final IconData icon;

  final List<Color> colors;

  final String? subtitle;

  const AnimatedStatCard({

    super.key,

    required this.title,

    required this.value,

    required this.icon,

    required this.colors,

    this.subtitle,
  });

  @override
  State<AnimatedStatCard>
      createState() =>
          _AnimatedStatCardState();
}

class _AnimatedStatCardState
    extends State<
        AnimatedStatCard>
    with
        SingleTickerProviderStateMixin {

  late AnimationController
      controller;

  late Animation<double>
      animation;

  @override
  void initState() {

    super.initState();

    controller =
        AnimationController(

      vsync: this,

      duration:
          const Duration(
        milliseconds: 900,
      ),
    );

    animation =
        CurvedAnimation(

      parent: controller,

      curve:
          Curves.easeOutBack,
    );

    controller.forward();
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

    return ScaleTransition(

      scale: animation,

      child: AppCard(

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment
                  .start,

          children: [

            Container(

              width: 58,
              height: 58,

              decoration:
                  BoxDecoration(

                gradient:
                    LinearGradient(
                  colors:
                      widget.colors,
                ),

                borderRadius:
                    BorderRadius.circular(
                        20),
              ),

              child: Icon(

                widget.icon,

                color:
                    Colors.white,

                size: 30,
              ),
            ),

            const SizedBox(
                height: 22),

            Text(

              widget.title,

              style: TextStyle(

                color: isDark

                    ? Colors.white60

                    : Colors.black54,

                fontSize: 15,

                fontWeight:
                    FontWeight.w600,
              ),
            ),

            const SizedBox(
                height: 10),

            Text(

              widget.value,

              style: TextStyle(

                color: isDark

                    ? Colors.white

                    : Colors.black87,

                fontSize: 28,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            if (widget.subtitle !=
                null) ...[

              const SizedBox(
                  height: 8),

              Text(

                widget.subtitle!,

                style: TextStyle(

                  color: isDark

                      ? Colors.white38

                      : Colors.black45,

                  fontSize: 13,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}