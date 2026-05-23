import 'package:flutter/material.dart';

class BmiCard extends StatefulWidget {

  const BmiCard({
    super.key,
  });

  @override
  State<BmiCard> createState() =>
      _BmiCardState();
}

class _BmiCardState
    extends State<BmiCard> {

  final TextEditingController
      heightController =
          TextEditingController();

  final TextEditingController
      weightController =
          TextEditingController();

  double bmi = 0;

  String category = '';

  void calculateBMI() {

    final height =
        double.tryParse(
          heightController.text,
        );

    final weight =
        double.tryParse(
          weightController.text,
        );

    if (height == null ||
        weight == null) {
      return;
    }

    final heightMeter =
        height / 100;

    final result =
        weight /
            (heightMeter *
                heightMeter);

    setState(() {

      bmi = result;

      if (result < 18.5) {

        category =
            'Underweight';

      } else if (result < 25) {

        category =
            'Normal';

      } else if (result < 30) {

        category =
            'Overweight';

      } else {

        category = 'Obese';
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final isDark =
        Theme.of(context)
                .brightness ==
            Brightness.dark;

    return Container(

      width: double.infinity,

      padding:
          const EdgeInsets.all(
              28),

      decoration: BoxDecoration(

        color: isDark

            ? const Color(
                0xFF121826)

            : Colors.white,

        borderRadius:
            BorderRadius.circular(
                30),

        boxShadow: isDark

            ? []

            : [

                BoxShadow(

                  color:
                      Colors.black12,

                  blurRadius: 18,

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

          Row(

            children: [

              Container(

                padding:
                    const EdgeInsets.all(
                        12),

                decoration:
                    BoxDecoration(

                  borderRadius:
                      BorderRadius.circular(
                          14),

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

                  Icons.monitor_weight,

                  color: Colors.white,
                ),
              ),

              const SizedBox(width: 16),

              Text(

                'BMI Calculator',

                style: TextStyle(

                  color: isDark

                      ? Colors.white

                      : Colors.black87,

                  fontSize: 24,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          buildInput(

            controller:
                heightController,

            hint:
                'Height (cm)',

            isDark:
                isDark,
          ),

          const SizedBox(height: 20),

          buildInput(

            controller:
                weightController,

            hint:
                'Weight (kg)',

            isDark:
                isDark,
          ),

          const SizedBox(height: 30),

          SizedBox(

            width: double.infinity,

            child: ElevatedButton(

              onPressed:
                  calculateBMI,

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
                          24),
                ),
              ),

              child: const Text(

                'Calculate BMI',

                style: TextStyle(

                  fontSize: 18,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
          ),

          if (bmi > 0) ...[

            const SizedBox(height: 35),

            Center(

              child: Column(

                children: [

                  Text(

                    bmi.toStringAsFixed(
                        1),

                    style: TextStyle(

                      color: isDark

                          ? Colors.white

                          : Colors.black87,

                      fontSize: 52,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                      height: 12),

                  Text(

                    category,

                    style: TextStyle(

                      color:
                          category ==
                                  'Normal'

                              ? Colors.green

                              : Colors.orange,

                      fontSize: 22,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget buildInput({

    required TextEditingController
        controller,

    required String hint,

    required bool isDark,

  }) {

    return Container(

      decoration:
          BoxDecoration(

        color: isDark

            ? const Color(
                0xFF1E293B)

            : const Color(
                0xFFF3F4F6),

        borderRadius:
            BorderRadius.circular(
                22),
      ),

      child: TextField(

        controller: controller,

        keyboardType:
            TextInputType.number,

        style: TextStyle(

          color: isDark

              ? Colors.white

              : Colors.black87,
        ),

        decoration: InputDecoration(

          contentPadding:
              const EdgeInsets.all(
                  20),

          border:
              InputBorder.none,

          hintText: hint,

          hintStyle: TextStyle(

            color: isDark

                ? Colors.white54

                : Colors.black45,
          ),
        ),
      ),
    );
  }
}