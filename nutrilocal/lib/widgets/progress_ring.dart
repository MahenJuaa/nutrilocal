import 'dart:math';

import 'package:flutter/material.dart';

class ProgressRing
    extends StatelessWidget {

  final double progress;

  final String value;

  final String label;

  final List<Color> colors;

  final double size;

  const ProgressRing({

    super.key,

    required this.progress,

    required this.value,

    required this.label,

    required this.colors,

    this.size = 180,
  });

  @override
  Widget build(BuildContext context) {

    final isDark =
        Theme.of(context)
                .brightness ==
            Brightness.dark;

    return SizedBox(

      width: size,
      height: size,

      child: Stack(

        alignment:
            Alignment.center,

        children: [

          SizedBox(

            width: size,
            height: size,

            child:
                CustomPaint(

              painter:
                  RingPainter(

                progress:
                    progress,

                colors:
                    colors,

                isDark:
                    isDark,
              ),
            ),
          ),

          Column(

            mainAxisAlignment:
                MainAxisAlignment
                    .center,

            children: [

              Text(

                value,

                style: TextStyle(

                  color: isDark

                      ? Colors.white

                      : Colors.black87,

                  fontSize:
                      size * 0.16,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                  height: 6),

              Text(

                label,

                style: TextStyle(

                  color: isDark

                      ? Colors.white60

                      : Colors.black54,

                  fontSize:
                      size * 0.07,

                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RingPainter
    extends CustomPainter {

  final double progress;

  final List<Color> colors;

  final bool isDark;

  RingPainter({

    required this.progress,

    required this.colors,

    required this.isDark,
  });

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {

    final strokeWidth =
        size.width * 0.09;

    final center =
        Offset(
      size.width / 2,
      size.height / 2,
    );

    final radius =
        (size.width / 2) -
            strokeWidth;

    final backgroundPaint =
        Paint()

          ..color = isDark

              ? const Color(
                  0xFF1E293B)

              : const Color(
                  0xFFE5E7EB)

          ..strokeWidth =
              strokeWidth

          ..style =
              PaintingStyle.stroke

          ..strokeCap =
              StrokeCap.round;

    canvas.drawCircle(

      center,

      radius,

      backgroundPaint,
    );

    final rect =
        Rect.fromCircle(

      center: center,

      radius: radius,
    );

    final progressPaint =
        Paint()

          ..shader =
              SweepGradient(

            startAngle:
                -pi / 2,

            endAngle:
                (2 * pi),

            colors:
                colors,
          ).createShader(rect)

          ..strokeWidth =
              strokeWidth

          ..style =
              PaintingStyle.stroke

          ..strokeCap =
              StrokeCap.round;

    canvas.drawArc(

      rect,

      -pi / 2,

      2 *
          pi *
          progress,

      false,

      progressPaint,
    );
  }

  @override
  bool shouldRepaint(
      covariant
      CustomPainter
          oldDelegate) {

    return true;
  }
}