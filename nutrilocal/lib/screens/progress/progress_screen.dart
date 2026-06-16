import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/nutrition_provider.dart';

import '../../widgets/app_section_title.dart';

import '../../widgets/app_card.dart';

import '../../widgets/progress_ring.dart';

import '../../widgets/animated_stat_card.dart';

import '../../widgets/ai_insight_card.dart';

class ProgressScreen
    extends StatelessWidget {

  const ProgressScreen({
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

    final textColor =
        isDark
            ? Colors.white
            : Colors.black87;

    return Scaffold(

      backgroundColor:
          Theme.of(context)
              .scaffoldBackgroundColor,

      body: SafeArea(

        child: SingleChildScrollView(

          padding:
              const EdgeInsets.all(
                  24),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [

              const AppSectionTitle(

                title:
                    'Progress Overview',

                subtitle:
                    'Monitor your calories, hydration, and nutrition achievements.',
              ),

              const SizedBox(
                  height: 34),

              Center(

                child:
                    ProgressRing(

                  progress:
                      (nutritionProvider.totalCalories /
                              nutritionProvider.calorieGoal)
                          .clamp(
                    0,
                    1,
                  ),

                  value:
                      '${nutritionProvider.totalCalories}',

                  label:
                      'Calories',

                  colors: const [

                    Color(
                        0xFF7C3AED),

                    Color(
                        0xFF06B6D4),
                  ],
                ),
              ),

              const SizedBox(
                  height: 34),

              AppCard(

                child: Row(

                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,

                  children: [

                    Column(

                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        Text(

                          'Daily Goal',

                          style:
                              TextStyle(

                            color: isDark

                                ? Colors.white60

                                : Colors.black54,

                            fontSize:
                                16,
                          ),
                        ),

                        const SizedBox(
                            height:
                                10),

                        Text(

                          '${nutritionProvider.calorieGoal} kcal',

                          style:
                              TextStyle(

                            color: textColor,

                            fontSize:
                                32,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    Container(

                      width: 72,
                      height: 72,

                      decoration:
                          BoxDecoration(

                        gradient:
                            const LinearGradient(
                          colors: [

                            Color(
                                0xFF7C3AED),

                            Color(
                                0xFF06B6D4),
                          ],
                        ),

                        borderRadius:
                            BorderRadius.circular(
                                24),
                      ),

                      child:
                          const Icon(

                        Icons.local_fire_department,

                        color:
                            Colors.white,

                        size: 38,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                  height: 28),

              Row(

                children: [

                  Expanded(

                    child:
                        AnimatedStatCard(

                      title:
                          'Water Intake',

                      value:
                          '${nutritionProvider.waterIntake} ml',

                      subtitle:
                          '${nutritionProvider.hydrationPercentage}% completed',

                      icon:
                          Icons.water_drop,

                      colors: const [

                        Color(
                            0xFF06B6D4),

                        Color(
                            0xFF38BDF8),
                      ],
                    ),
                  ),

                  const SizedBox(
                      width: 18),

                  Expanded(

                    child:
                        AnimatedStatCard(

                      title:
                          'Meals',

                      value:
                          '${nutritionProvider.totalMeals}',

                      subtitle:
                          'Tracked meals',

                      icon:
                          Icons.fastfood,

                      colors: const [

                        Color(
                            0xFF7C3AED),

                        Color(
                            0xFFA855F7),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(
                  height: 18),

              Row(

                children: [

                  Expanded(

                    child:
                        AnimatedStatCard(

                      title:
                          'Average',

                      value:
                          '${nutritionProvider.averageCalories}',

                      subtitle:
                          'Calories / meal',

                      icon:
                          Icons.analytics,

                      colors: const [

                        Color(
                            0xFFF59E0B),

                        Color(
                            0xFFFBBF24),
                      ],
                    ),
                  ),

                  const SizedBox(
                      width: 18),

                  Expanded(

                    child:
                        AnimatedStatCard(

                      title:
                          'Streak',

                      value:
                          '${nutritionProvider.streakDays}',

                      subtitle:
                          'Healthy days',

                      icon:
                          Icons.emoji_events,

                      colors: const [

                        Color(
                            0xFFEF4444),

                        Color(
                            0xFFF97316),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(
                  height: 28),

              const AiInsightCard(),

              const SizedBox(
                  height: 120),
            ],
          ),
        ),
      ),
    );
  }
}