import 'package:flutter/material.dart';

class EmptyState
    extends StatelessWidget {

  final IconData icon;

  final String title;

  final String subtitle;

  final String buttonText;

  final VoidCallback onTap;

  const EmptyState({

    super.key,

    required this.icon,

    required this.title,

    required this.subtitle,

    required this.buttonText,

    required this.onTap,
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
            const EdgeInsets.symmetric(
          horizontal: 30,
        ),

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

                shape: BoxShape.circle,

                gradient:
                    const LinearGradient(
                  colors: [

                    Color(0xFF7C3AED),

                    Color(0xFF06B6D4),
                  ],
                ),

                boxShadow: [

                  BoxShadow(

                    color:
                        const Color(
                          0xFF7C3AED,
                        ).withOpacity(
                          0.4,
                        ),

                    blurRadius: 40,

                    spreadRadius: 5,
                  ),
                ],
              ),

              child: Icon(

                icon,

                color: Colors.white,

                size: 90,
              ),
            ),

            const SizedBox(height: 40),

            Text(

              title,

              textAlign:
                  TextAlign.center,

              style: TextStyle(

                color: isDark

                    ? Colors.white

                    : Colors.black87,

                fontSize: 30,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            Text(

              subtitle,

              textAlign:
                  TextAlign.center,

              style: TextStyle(

                color: isDark

                    ? Colors.white70

                    : Colors.black54,

                fontSize: 18,

                height: 1.7,
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                onPressed: onTap,

                style:
                    ElevatedButton.styleFrom(

                  backgroundColor:
                      const Color(
                          0xFF7C3AED),

                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 20,
                  ),

                  shape:
                      RoundedRectangleBorder(

                    borderRadius:
                        BorderRadius.circular(
                            24),
                  ),

                  elevation: 10,
                ),

                child: Text(

                  buttonText,

                  style: const TextStyle(

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