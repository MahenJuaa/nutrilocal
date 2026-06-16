import 'package:flutter/material.dart';

class AppSectionTitle
    extends StatelessWidget {

  final String title;

  final String? subtitle;

  final Widget? action;

  const AppSectionTitle({

    super.key,

    required this.title,

    this.subtitle,

    this.action,
  });

  @override
  Widget build(BuildContext context) {

    final isDark =
        Theme.of(context)
                .brightness ==
            Brightness.dark;

    return Row(

      crossAxisAlignment:
          CrossAxisAlignment.end,

      mainAxisAlignment:
          MainAxisAlignment
              .spaceBetween,

      children: [

        Expanded(

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [

              Text(

                title,

                style: TextStyle(

                  color: isDark

                      ? Colors.white

                      : Colors.black87,

                  fontSize: 30,

                  height: 1.1,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              if (subtitle !=
                  null) ...[

                const SizedBox(
                    height: 8),

                Text(

                  subtitle!,

                  style: TextStyle(

                    color: isDark

                        ? Colors.white60

                        : Colors.black54,

                    fontSize: 15,

                    fontWeight:
                        FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),

        if (action != null)
          action!,
      ],
    );
  }
}