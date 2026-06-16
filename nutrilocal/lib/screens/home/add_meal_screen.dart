import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/nutrition_provider.dart';

class AddMealScreen
    extends StatefulWidget {

  AddMealScreen({
    super.key,
  });

  @override
  State<AddMealScreen>
      createState() =>
          _AddMealScreenState();
}

class _AddMealScreenState
    extends State<
        AddMealScreen> {

  final nameController =
      TextEditingController();

  final calorieController =
      TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    final nutritionProvider =
        context.watch<
            NutritionProvider>();

    final isDark =
        Theme.of(context)
                .brightness ==
            Brightness.dark;

    return Scaffold(

      backgroundColor:
          Theme.of(context)
              .scaffoldBackgroundColor,

      appBar: AppBar(

        title: const Text(
          'Add Meal',
        ),
      ),

      body:
          SingleChildScrollView(

        padding:
            const EdgeInsets.all(
                24),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment
                  .start,

          children: [

            Container(

              width:
                  double.infinity,

              padding:
                  const EdgeInsets.all(
                      28),

              decoration:
                  BoxDecoration(

                borderRadius:
                    BorderRadius.circular(
                        32),

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
                        24,

                    offset:
                        const Offset(
                      0,
                      10,
                    ),
                  ),
                ],
              ),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  const Icon(

                    Icons.restaurant,

                    color:
                        Colors.white,

                    size: 54,
                  ),

                  const SizedBox(
                      height:
                          22),

                  const Text(

                    'Track Your Meal 🍽️',

                    style: TextStyle(

                      color:
                          Colors.white,

                      fontSize:
                          30,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                      height:
                          10),

                  const Text(

                    'Add your food intake and monitor calories with smart nutrition tracking.',

                    style: TextStyle(

                      color:
                          Colors.white70,

                      fontSize:
                          16,

                      height:
                          1.6,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
                height: 34),

            buildInputField(

              context: context,

              controller:
                  nameController,

              hint:
                  'Meal Name',

              icon:
                  Icons.fastfood,
            ),

            const SizedBox(
                height: 22),

            buildInputField(

              context: context,

              controller:
                  calorieController,

              hint:
                  'Calories',

              icon:
                  Icons.local_fire_department,

              keyboardType:
                  TextInputType
                      .number,
            ),

            const SizedBox(
                height: 36),

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
                    isLoading

                        ? null

                        : () async {

                            final name =
                                nameController
                                    .text
                                    .trim();

                            final calories =
                                int.tryParse(
                                      calorieController
                                          .text,
                                    ) ??
                                    0;

                            if (name
                                    .isEmpty ||
                                calories <=
                                    0) {

                              ScaffoldMessenger.of(
                                      context)
                                  .showSnackBar(

                                const SnackBar(

                                  content:
                                      Text(
                                    'Please fill all fields correctly',
                                  ),
                                ),
                              );

                              return;
                            }

                            setState(() {

                              isLoading =
                                  true;
                            });

                            await Future.delayed(

                              const Duration(
                                milliseconds:
                                    800,
                              ),
                            );

                            nutritionProvider
                                .addMeal(

                              name,

                              calories,
                            );

                            if (!mounted) {
                              return;
                            }

                            setState(() {

                              isLoading =
                                  false;
                            });

                            ScaffoldMessenger.of(
                                    context)
                                .showSnackBar(

                              const SnackBar(

                                content:
                                    Text(
                                  'Meal added successfully',
                                ),
                              ),
                            );

                            Navigator.pop(
                                context);
                          },

                child:
                    isLoading

                        ? const CircularProgressIndicator(
                            color:
                                Colors.white,
                          )

                        : const Text(

                            'Save Meal',

                            style:
                                TextStyle(

                              color:
                                  Colors.white,

                              fontSize:
                                  20,

                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
              ),
            ),

            const SizedBox(
                height: 24),

            Container(

              width:
                  double.infinity,

              padding:
                  const EdgeInsets.all(
                      24),

              decoration:
                  BoxDecoration(

                borderRadius:
                    BorderRadius.circular(
                        28),

                color: isDark

                    ? const Color(
                        0xFF111827)

                    : Colors.white,

                boxShadow: [

                  BoxShadow(

                    color:
                        Colors.black
                            .withOpacity(
                      0.05,
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

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  Text(

                    'Nutrition Tips 💡',

                    style: TextStyle(

                      color: isDark

                          ? Colors.white

                          : Colors.black87,

                      fontSize: 22,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                      height:
                          18),

                  buildTip(
                    'Choose balanced meals with protein and fiber.',
                  ),

                  buildTip(
                    'Drink enough water throughout the day.',
                  ),

                  buildTip(
                    'Avoid excessive sugar and processed food.',
                  ),

                  buildTip(
                    'Track calories consistently for better results.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputField({

    required BuildContext
        context,

    required TextEditingController
        controller,

    required String hint,

    required IconData icon,

    TextInputType
        keyboardType =
            TextInputType.text,

  }) {

    final isDark =
        Theme.of(context)
                .brightness ==
            Brightness.dark;

    return TextField(

      controller: controller,

      keyboardType:
          keyboardType,

      style: TextStyle(

        color: isDark

            ? Colors.white

            : Colors.black87,
      ),

      decoration: InputDecoration(

        hintText: hint,

        hintStyle: TextStyle(

          color: isDark

              ? Colors.white38

              : Colors.black38,
        ),

        prefixIcon:
            Icon(icon),

        filled: true,

        fillColor: isDark

            ? const Color(
                0xFF111827)

            : Colors.white,

        border:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(
                  24),

          borderSide:
              BorderSide.none,
        ),
      ),
    );
  }

  Widget buildTip(
    String text,
  ) {

    return Padding(

      padding:
          const EdgeInsets.only(
              bottom: 14),

      child: Row(

        crossAxisAlignment:
            CrossAxisAlignment
                .start,

        children: [

          const Padding(

            padding:
                EdgeInsets.only(
                    top: 4),

            child: Icon(

              Icons.check_circle,

              color:
                  Color(
                      0xFF06B6D4),

              size: 18,
            ),
          ),

          const SizedBox(
              width: 12),

          Expanded(

            child: Text(

              text,

              style:
                  const TextStyle(

                height: 1.6,

                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}