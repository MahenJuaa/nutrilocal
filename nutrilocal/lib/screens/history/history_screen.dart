import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/nutrition_provider.dart';

import '../../widgets/empty_state_widget.dart';

import '../../widgets/app_section_title.dart';

import '../../widgets/app_card.dart';

import '../home/add_meal_screen.dart';

class HistoryScreen
    extends StatelessWidget {

  HistoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final nutritionProvider =
        Provider.of<NutritionProvider>(
            context);

    final isDark =
        Theme.of(context)
                .brightness ==
            Brightness.dark;

    final textColor =
        Theme.of(context)
            .colorScheme
            .onSurface;

    final subtitleColor =
        isDark
            ? Colors.white70
            : Colors.black54;

    return Scaffold(

      backgroundColor:
          Theme.of(context)
              .scaffoldBackgroundColor,

      body: SafeArea(

        child: Padding(

          padding:
              const EdgeInsets.all(
                  24),

          child:
              nutritionProvider
                      .meals
                      .isEmpty

                  ? EmptyStateWidget(

                      icon:
                          Icons.history,

                      title:
                          'No History Yet',

                      description:
                          'Your meal history will appear here after tracking nutrition.',

                      buttonText:
                          'Start Tracking',

                      onPressed:
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
                    )

                  : Column(

                      children: [

                        const AppSectionTitle(

                          title:
                              'Meal History',

                          subtitle:
                              'Track your nutrition journey and monitor your eating habits.',
                        ),

                        const SizedBox(
                            height:
                                28),

                        Expanded(

                          child:
                              ListView.builder(

                            itemCount:
                                nutritionProvider
                                    .meals
                                    .length,

                            itemBuilder:
                                (
                                  context,
                                  index,
                                ) {

                              final meal =
                                  nutritionProvider
                                      .meals[index];

                              return Padding(

                                padding:
                                    const EdgeInsets.only(
                                  bottom:
                                      18,
                                ),

                                child:
                                    AppCard(

                                  child:
                                      Row(

                                    children: [

                                      Container(

                                        width:
                                            72,

                                        height:
                                            72,

                                        decoration:
                                            BoxDecoration(

                                          borderRadius:
                                              BorderRadius.circular(
                                            22,
                                          ),

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

                                          Icons.restaurant,

                                          color:
                                              Colors.white,

                                          size:
                                              34,
                                        ),
                                      ),

                                      const SizedBox(
                                          width:
                                              20),

                                      Expanded(

                                        child:
                                            Column(

                                          crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,

                                          children: [

                                            Text(

                                              meal.name,

                                              style:
                                                  TextStyle(

                                                color:
                                                    textColor,

                                                fontSize:
                                                    22,

                                                fontWeight:
                                                    FontWeight.bold,
                                              ),
                                            ),

                                            const SizedBox(
                                                height:
                                                    8),

                                            Text(

                                              '${meal.calories} kcal',

                                              style:
                                                  TextStyle(

                                                color:
                                                    subtitleColor,

                                                fontSize:
                                                    16,

                                                fontWeight:
                                                    FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Container(

                                        decoration:
                                            BoxDecoration(

                                          color:
                                              Colors.red
                                                  .withOpacity(
                                            0.12,
                                          ),

                                          borderRadius:
                                              BorderRadius.circular(
                                            18,
                                          ),
                                        ),

                                        child:
                                            IconButton(

                                          onPressed:
                                              () {

                                            nutritionProvider
                                                .deleteMeal(
                                              index,
                                            );
                                          },

                                          icon:
                                              const Icon(

                                            Icons.delete,

                                            color:
                                                Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}