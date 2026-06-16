import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/nutrition_provider.dart';

class EditMealSheet
    extends StatefulWidget {

  final int index;

  final String initialName;

  final int initialCalories;

  const EditMealSheet({

    super.key,

    required this.index,

    required this.initialName,

    required this.initialCalories,
  });

  @override
  State<EditMealSheet> createState() =>
      _EditMealSheetState();
}

class _EditMealSheetState
    extends State<EditMealSheet> {

  late TextEditingController
      nameController;

  late TextEditingController
      caloriesController;

  @override
  void initState() {
    super.initState();

    nameController =
        TextEditingController(
      text: widget.initialName,
    );

    caloriesController =
        TextEditingController(
      text: widget.initialCalories
          .toString(),
    );
  }

  @override
  Widget build(BuildContext context) {

    final nutritionProvider =
        context.read<NutritionProvider>();

    return Container(

      padding: const EdgeInsets.all(24),

      decoration: const BoxDecoration(

        color: Color(0xFF121826),

        borderRadius:
            BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),

      child: Column(

        mainAxisSize:
            MainAxisSize.min,

        children: [

          Container(

            width: 60,
            height: 6,

            decoration: BoxDecoration(

              color: Colors.white24,

              borderRadius:
                  BorderRadius.circular(
                      20),
            ),
          ),

          const SizedBox(height: 30),

          const Text(

            'Edit Meal',

            style: TextStyle(

              color: Colors.white,

              fontSize: 24,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 30),

          TextField(

            controller: nameController,

            style: const TextStyle(
              color: Colors.white,
            ),

            decoration: InputDecoration(

              hintText: 'Meal name',

              hintStyle:
                  const TextStyle(
                color: Colors.white54,
              ),

              filled: true,

              fillColor:
                  const Color(0xFF1E293B),

              border:
                  OutlineInputBorder(

                borderRadius:
                    BorderRadius.circular(
                        20),

                borderSide:
                    BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 20),

          TextField(

            controller:
                caloriesController,

            keyboardType:
                TextInputType.number,

            style: const TextStyle(
              color: Colors.white,
            ),

            decoration: InputDecoration(

              hintText: 'Calories',

              hintStyle:
                  const TextStyle(
                color: Colors.white54,
              ),

              filled: true,

              fillColor:
                  const Color(0xFF1E293B),

              border:
                  OutlineInputBorder(

                borderRadius:
                    BorderRadius.circular(
                        20),

                borderSide:
                    BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(

            width: double.infinity,

            child: ElevatedButton(

              onPressed: () async {

                final calories =
                    int.tryParse(
                  caloriesController
                      .text,
                );

                if (calories == null) {
                  return;
                }

                await nutritionProvider
                    .editMeal(

                  index: widget.index,

                  name:
                      nameController.text,

                  calories: calories,
                );

                if (!context.mounted) {
                  return;
                }

                Navigator.pop(context);
              },

              child: const Text(
                'Save Changes',
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}