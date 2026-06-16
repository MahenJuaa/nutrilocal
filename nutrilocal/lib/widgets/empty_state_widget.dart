import 'package:flutter/material.dart';

class EmptyStateWidget
    extends StatelessWidget {

  final IconData icon;

  final String title;

  final String description;

  final String buttonText;

  final VoidCallback onPressed;

  const EmptyStateWidget({

    super.key,

    required this.icon,

    required this.title,

    required this.description,

    required this.buttonText,

    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    final isDark =
        Theme.of(context)
                .brightness ==
            Brightness.dark;

    return Center(

      child: Padding(

        padding:
            const EdgeInsets.all(
                24),

        child: Column(

          mainAxisAlignment:
              MainAxisAlignment
                  .center,

          children: [

            Container(

              width: 180,
              height: 180,

              decoration:
                  BoxDecoration(

                shape:
                    BoxShape.circle,

                gradient:
                    const LinearGradient(
                  colors: [

                    Color(
                        0xFF7C3AED),

                    Color(
                        0xFF06B6D4),
                  ],
                ),

                boxShadow: [

                  BoxShadow(

                    color:
                        const Color(
                      0xFF7C3AED,
                    ).withOpacity(
                      0.35,
                    ),

                    blurRadius:
                        40,

                    spreadRadius:
                        10,
                  ),
                ],
              ),

              child: Icon(

                icon,

                size: 80,

                color:
                    Colors.white,
              ),
            ),

            const SizedBox(
                height: 40),

            Text(

              title,

              textAlign:
                  TextAlign.center,

              style: TextStyle(

                color: isDark

                    ? Colors.white

                    : Colors.black87,

                fontSize: 36,

                height: 1.2,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
                height: 18),

            Text(

              description,

              textAlign:
                  TextAlign.center,

              style: TextStyle(

                color: isDark

                    ? Colors.white60

                    : Colors.black54,

                fontSize: 18,

                height: 1.7,
              ),
            ),

            const SizedBox(
                height: 40),

            Container(

              width:
                  double.infinity,

              height: 68,

              decoration:
                  BoxDecoration(

                borderRadius:
                    BorderRadius.circular(
                        26),

                gradient:
                    const LinearGradient(
                  colors: [

                    Color(
                        0xFF7C3AED),

                    Color(
                        0xFF06B6D4),
                  ],
                ),

                boxShadow: [

                  BoxShadow(

                    color:
                        const Color(
                      0xFF7C3AED,
                    ).withOpacity(
                      0.35,
                    ),

                    blurRadius:
                        20,

                    offset:
                        const Offset(
                      0,
                      8,
                    ),
                  ),
                ],
              ),

              child:
                  ElevatedButton(

                style:
                    ElevatedButton.styleFrom(

                  backgroundColor:
                      Colors.transparent,

                  shadowColor:
                      Colors.transparent,

                  shape:
                      RoundedRectangleBorder(

                    borderRadius:
                        BorderRadius.circular(
                            26),
                  ),
                ),

                onPressed:
                    onPressed,

                child: Text(

                  buttonText,

                  style:
                      const TextStyle(

                    color:
                        Colors.white,

                    fontSize: 20,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}