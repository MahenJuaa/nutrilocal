import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/nutrition_provider.dart';

class GoalSettingsSheet
    extends StatefulWidget {

  const GoalSettingsSheet({
    super.key,
  });

  @override
  State<GoalSettingsSheet>
      createState() =>
          _GoalSettingsSheetState();
}

class _GoalSettingsSheetState
    extends State<GoalSettingsSheet> {

  late TextEditingController
      calorieController;

  late TextEditingController
      waterController;

  @override
  void initState() {
    super.initState();

    final nutritionProvider =
        context.read<NutritionProvider>();

    calorieController =
        TextEditingController(

      text: nutritionProvider
          .calorieGoal
          .toString(),
    );

    waterController =
        TextEditingController(

      text: nutritionProvider
          .waterGoal
          .toString(),
    );
  }

  @override
  void dispose() {

    calorieController.dispose();

    waterController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final nutritionProvider =
        context.watch<NutritionProvider>();

    return Container(

      padding:
          const EdgeInsets.all(28),

      decoration: const BoxDecoration(

        color: Color(0xFF121826),

        borderRadius:
            BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),

      child: SingleChildScrollView(

        child: Column(

          mainAxisSize:
              MainAxisSize.min,

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Center(

              child: Container(

                width: 70,
                height: 6,

                decoration:
                    BoxDecoration(

                  color: Colors.white24,

                  borderRadius:
                      BorderRadius.circular(
                          20),
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(

              'Daily Goals',

              style: TextStyle(

                color: Colors.white,

                fontSize: 28,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(

              'Customize your nutrition targets',

              style: TextStyle(
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 35),

            const Text(

              'Calories Goal',

              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 14),

            TextField(

              controller:
                  calorieController,

              keyboardType:
                  TextInputType.number,

              style: const TextStyle(
                color: Colors.white,
              ),

              decoration: InputDecoration(

                hintText:
                    'Enter calorie goal',

                hintStyle:
                    const TextStyle(
                  color: Colors.white54,
                ),

                filled: true,

                fillColor:
                    const Color(
                        0xFF1E293B),

                border:
                    OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(
                          22),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 28),

            const Text(

              'Water Goal (ml)',

              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 14),

            TextField(

              controller:
                  waterController,

              keyboardType:
                  TextInputType.number,

              style: const TextStyle(
                color: Colors.white,
              ),

              decoration: InputDecoration(

                hintText:
                    'Enter water goal',

                hintStyle:
                    const TextStyle(
                  color: Colors.white54,
                ),

                filled: true,

                fillColor:
                    const Color(
                        0xFF1E293B),

                border:
                    OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(
                          22),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                onPressed: () async {

                  final calories =
                      int.tryParse(
                    calorieController
                        .text,
                  );

                  final water =
                      int.tryParse(
                    waterController
                        .text,
                  );

                  if (calories == null ||
                      water == null) {
                    return;
                  }

                  await nutritionProvider
                      .updateGoals(

                    calories:
                        calories,

                    water: water,
                  );

                  if (!context.mounted) {
                    return;
                  }

                  Navigator.pop(context);

                  ScaffoldMessenger.of(
                          context)
                      .showSnackBar(

                    const SnackBar(

                      backgroundColor:
                          Colors.green,

                      content: Text(
                        'Goals updated successfully',
                      ),
                    ),
                  );
                },

                style:
                    ElevatedButton.styleFrom(

                  backgroundColor:
                      const Color(
                          0xFF7C3AED),

                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 18,
                  ),

                  shape:
                      RoundedRectangleBorder(

                    borderRadius:
                        BorderRadius.circular(
                            20),
                  ),
                ),

                child: const Text(

                  'Save Goals',

                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}