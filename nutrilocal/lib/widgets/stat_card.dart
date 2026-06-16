import 'package:flutter/material.dart';

class StatCard
    extends StatelessWidget {

  final IconData icon;

  final String title;

  final String value;

  final Color color;

  const StatCard({

    super.key,

    required this.icon,

    required this.title,

    required this.value,

    required this.color,
  });

  @override
  Widget build(BuildContext context) {

    final isDark =

        Theme.of(context)
                .brightness ==

            Brightness.dark;

    return Container(

      padding:
          const EdgeInsets.all(
              20),

      decoration:
          BoxDecoration(

        color: isDark

            ? const Color(
                0xFF121826)

            : Colors.white,

        borderRadius:
            BorderRadius.circular(
                28),

        boxShadow:

            isDark

                ? []

                : [

                    BoxShadow(

                      color:
                          Colors.black12,

                      blurRadius: 18,

                      offset:
                          const Offset(
                        0,
                        8,
                      ),
                    ),
                  ],
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment
                .start,

        children: [

          Icon(

            icon,

            color: color,

            size: 34,
          ),

          const Spacer(),

          Text(

            title,

            style: TextStyle(

              color: isDark

                  ? Colors.white70

                  : Colors.black54,

              fontSize: 16,
            ),
          ),

          const SizedBox(height: 12),

          FittedBox(

            fit: BoxFit.scaleDown,

            child: Text(

              value,

              maxLines: 1,

              style: TextStyle(

                color: isDark

                    ? Colors.white

                    : Colors.black87,

                fontSize: 30,

                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}