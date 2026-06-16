import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/nutrition_provider.dart';

import 'app_card.dart';

class AiInsightCard
    extends StatelessWidget {

  const AiInsightCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final nutritionProvider =
        context.watch<
            NutritionProvider>();

    final isDark =
        Theme.of(context)
                .brightness ==
            Brightness.dark;

    return AppCard(

      padding:
          const EdgeInsets.all(
              26),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment
                .start,

        children: [

          Row(

            children: [

              Container(

                width: 58,
                height: 58,

                decoration:
                    BoxDecoration(

                  borderRadius:
                      BorderRadius.circular(
                          18),

                  gradient:
                      const LinearGradient(
                    colors: [

                      Color(
                          0xFF7C3AED),

                      Color(
                          0xFF06B6D4),
                    ],
                  ),
                ),

                child: const Icon(

                  Icons.auto_awesome,

                  color:
                      Colors.white,

                  size: 30,
                ),
              ),

              const SizedBox(
                  width: 18),

              Expanded(

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    Text(

                      'AI Nutrition Insight',

                      style:
                          TextStyle(

                        color: isDark

                            ? Colors.white

                            : Colors.black87,

                        fontSize:
                            22,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                        height:
                            6),

                    Text(

                      'Smart recommendation based on your nutrition pattern.',

                      style:
                          TextStyle(

                        color: isDark

                            ? Colors.white60

                            : Colors.black54,

                        fontSize:
                            14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(
              height: 28),

          Container(

            width:
                double.infinity,

            padding:
                const EdgeInsets.all(
                    22),

            decoration:
                BoxDecoration(

              borderRadius:
                  BorderRadius.circular(
                      24),

              gradient:
                  LinearGradient(

                begin:
                    Alignment.topLeft,

                end:
                    Alignment.bottomRight,

                colors: isDark

                    ? [

                        const Color(
                            0xFF1E1B4B),

                        const Color(
                            0xFF0F172A),
                      ]

                    : [

                        const Color(
                            0xFFF5F3FF),

                        const Color(
                            0xFFE0F2FE),
                      ],
              ),
            ),

            child: Text(

              nutritionProvider
                  .aiInsight,

              style: TextStyle(

                color: isDark

                    ? Colors.white

                    : Colors.black87,

                fontSize: 16,

                height: 1.7,

                fontWeight:
                    FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}