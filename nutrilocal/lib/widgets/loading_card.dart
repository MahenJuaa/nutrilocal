import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({super.key});

  @override
  Widget build(BuildContext context) {

    return Shimmer.fromColors(

      baseColor:
          const Color(0xFF1E293B),

      highlightColor:
          const Color(0xFF2A3441),

      child: Container(

        margin:
            const EdgeInsets.only(
          bottom: 18,
        ),

        padding:
            const EdgeInsets.all(
                22),

        decoration: BoxDecoration(

          color:
              const Color(0xFF121826),

          borderRadius:
              BorderRadius.circular(
                  28),
        ),

        child: Row(

          children: [

            Container(

              width: 60,
              height: 60,

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                        18),
              ),
            ),

            const SizedBox(width: 18),

            Expanded(

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  Container(

                    width: double.infinity,
                    height: 20,

                    decoration: BoxDecoration(

                      color: Colors.white,

                      borderRadius:
                          BorderRadius.circular(
                              10),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(

                    width: 100,
                    height: 16,

                    decoration: BoxDecoration(

                      color: Colors.white,

                      borderRadius:
                          BorderRadius.circular(
                              10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}