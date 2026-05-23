import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/nutrition_provider.dart';

import '../../widgets/app_card.dart';

import '../../widgets/app_section_title.dart';

import '../../widgets/progress_ring.dart';

import '../../widgets/animated_stat_card.dart';

import '../../widgets/ai_insight_card.dart';

import '../home/add_meal_screen.dart';

class HomeScreen
    extends StatelessWidget {

  const HomeScreen({
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

    final subtitleColor =
        isDark
            ? Colors.white60
            : Colors.black54;

    return Scaffold(

      backgroundColor:
          Theme.of(context)
              .scaffoldBackgroundColor,

      floatingActionButton:
          Container(

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
                  20,

              offset:
                  const Offset(
                0,
                8,
              ),
            ),
          ],
        ),

        child: FloatingActionButton(

          backgroundColor:
              Colors.transparent,

          elevation: 0,

          onPressed: () {

            Navigator.push(

              context,

              MaterialPageRoute(

                builder:
                    (_) =>
                        AddMealScreen(),
              ),
            );
          },

          child: const Icon(

            Icons.add,

            color: Colors.white,

            size: 34,
          ),
        ),
      ),

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

              AppSectionTitle(

                title:
                    'NutriLocal',

                subtitle:
                    'Track your nutrition and stay healthy every day.',

                action:
                    Container(

                  padding:
                      const EdgeInsets.all(
                          14),

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

                    Icons.restaurant_menu,

                    color:
                        Colors.white,
                  ),
                ),
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
                  height: 32),

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

                            color: subtitleColor,

                            fontSize:
                                16,
                          ),
                        ),

                        const SizedBox(
                            height:
                                8),

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

                        borderRadius:
                            BorderRadius.circular(
                                24),

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

                      child:
                          const Icon(

                        Icons.local_fire_department,

                        color:
                            Colors.white,

                        size: 36,
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
                  height: 28),

              AppCard(

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    Text(

                      'Quick Actions',

                      style:
                          TextStyle(

                        color: textColor,

                        fontSize: 24,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                        height:
                            24),

                    Row(

                      children: [

                        Expanded(

                          child:
                              buildActionButton(

                            title:
                                'Drink Water',

                            icon:
                                Icons.water_drop,

                            colors: const [

                              Color(
                                  0xFF06B6D4),

                              Color(
                                  0xFF38BDF8),
                            ],

                            onTap:
                                () {

                              nutritionProvider
                                  .addWater(
                                      250);
                            },
                          ),
                        ),

                        const SizedBox(
                            width:
                                18),

                        Expanded(

                          child:
                              buildActionButton(

                            title:
                                'Add Meal',

                            icon:
                                Icons.fastfood,

                            colors: const [

                              Color(
                                  0xFF7C3AED),

                              Color(
                                  0xFFA855F7),
                            ],

                            onTap:
                                () {

                              Navigator.push(

                                context,

                                MaterialPageRoute(

                                  builder:
                                      (_) =>
                                          AddMealScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(
                  height: 140),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildActionButton({

    required String title,

    required IconData icon,

    required List<Color> colors,

    required VoidCallback
        onTap,

  }) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        padding:
            const EdgeInsets.symmetric(

          vertical: 24,
        ),

        decoration:
            BoxDecoration(

          borderRadius:
              BorderRadius.circular(
                  24),

          gradient:
              LinearGradient(
            colors: colors,
          ),
        ),

        child: Column(

          children: [

            Icon(

              icon,

              color:
                  Colors.white,

              size: 34,
            ),

            const SizedBox(
                height:
                    14),

            const Text(

              'Action',

              style: TextStyle(

                color:
                    Colors.white70,

                fontSize: 13,
              ),
            ),

            const SizedBox(
                height:
                    4),

            Text(

              title,

              style:
                  const TextStyle(

                color:
                    Colors.white,

                fontSize:
                    17,

                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}