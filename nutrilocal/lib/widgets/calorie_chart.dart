import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';

class CalorieChart
    extends StatelessWidget {

  final List<double> values;

  const CalorieChart({

    super.key,

    required this.values,
  });

  @override
  Widget build(BuildContext context) {

    final isDark =
        Theme.of(context)
                .brightness ==
            Brightness.dark;

    return Container(

      height: 320,

      padding:
          const EdgeInsets.all(
              20),

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

      child: LineChart(

        LineChartData(

          minY: 0,

          maxY: 2200,

          gridData: FlGridData(

            show: true,

            drawVerticalLine:
                false,

            getDrawingHorizontalLine:
                (value) {

              return FlLine(

                color: isDark

                    ? Colors.white12

                    : Colors.black12,

                strokeWidth: 1,
              );
            },
          ),

          borderData:
              FlBorderData(
            show: false,
          ),

          titlesData: FlTitlesData(

            leftTitles:
                AxisTitles(

              sideTitles:
                  SideTitles(

                showTitles:
                    true,

                reservedSize:
                    40,

                getTitlesWidget:
                    (value, meta) {

                  return Text(

                    value
                        .toInt()
                        .toString(),

                    style:
                        TextStyle(

                      color:
                          isDark

                              ? Colors
                                  .white70

                              : Colors
                                  .black54,

                      fontSize:
                          12,
                    ),
                  );
                },
              ),
            ),

            topTitles:
                const AxisTitles(

              sideTitles:
                  SideTitles(
                showTitles:
                    false,
              ),
            ),

            rightTitles:
                const AxisTitles(

              sideTitles:
                  SideTitles(
                showTitles:
                    false,
              ),
            ),

            bottomTitles:
                AxisTitles(

              sideTitles:
                  SideTitles(

                showTitles:
                    true,

                getTitlesWidget:
                    (value, meta) {

                  const days = [

                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                    'Sun',
                  ];

                  return Padding(

                    padding:
                        const EdgeInsets.only(
                      top: 12,
                    ),

                    child: Text(

                      days[value
                          .toInt()],

                      style:
                          TextStyle(

                        color:
                            isDark

                                ? Colors
                                    .white70

                                : Colors
                                    .black54,

                        fontSize:
                            14,
                      ),
                    ),
                  );
                },

                reservedSize:
                    32,
              ),
            ),
          ),

          lineBarsData: [

            LineChartBarData(

              isCurved: true,

              gradient:
                  const LinearGradient(
                colors: [

                  Color(
                      0xFF7C3AED),

                  Color(
                      0xFF06B6D4),
                ],
              ),

              barWidth: 6,

              dotData:
                  FlDotData(
                show: true,
              ),

              belowBarData:
                  BarAreaData(

                show: true,

                gradient:
                    LinearGradient(
                  colors: [

                    const Color(
                            0xFF7C3AED)
                        .withOpacity(
                            0.25),

                    const Color(
                            0xFF06B6D4)
                        .withOpacity(
                            0.08),
                  ],
                ),
              ),

              spots:
                  values
                      .asMap()
                      .entries
                      .map(

                        (e) => FlSpot(

                          e.key
                              .toDouble(),

                          e.value,
                        ),
                      )
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }
}