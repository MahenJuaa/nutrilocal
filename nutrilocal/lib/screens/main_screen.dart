import 'package:flutter/material.dart';

import 'home/home_screen.dart';

import 'home/add_meal_screen.dart';

import 'history/history_screen.dart';

import 'progress/progress_screen.dart';

import 'profile/profile_screen.dart';

class MainScreen
    extends StatefulWidget {

  MainScreen({
    super.key,
  });

  @override
  State<MainScreen>
      createState() =>
          _MainScreenState();
}

class _MainScreenState
    extends State<MainScreen>
    with
        TickerProviderStateMixin {

  int currentIndex = 0;

  final List<Widget> screens = [

    HomeScreen(),

    HistoryScreen(),

    ProgressScreen(),

    ProfileScreen(),
  ];

  final List<IconData> icons = [

    Icons.home_rounded,

    Icons.history_rounded,

    Icons.analytics_rounded,

    Icons.person_rounded,
  ];

  final List<String> labels = [

    'Home',

    'History',

    'Progress',

    'Profile',
  ];

  @override
  Widget build(BuildContext context) {

    final isDark =
        Theme.of(context)
                .brightness ==
            Brightness.dark;

    return Scaffold(

      extendBody: true,

      floatingActionButton:
          FloatingActionButton(

        backgroundColor:
            const Color(
                0xFF7C3AED),

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

          color:
              Colors.white,
        ),
      ),

      body:
          AnimatedSwitcher(

        duration:
            const Duration(
          milliseconds: 350,
        ),

        child:
            screens[currentIndex],
      ),

      bottomNavigationBar:
          Container(

        margin:
            const EdgeInsets.fromLTRB(

          20,
          0,
          20,
          24,
        ),

        padding:
            const EdgeInsets.symmetric(

          horizontal: 16,

          vertical: 14,
        ),

        decoration:
            BoxDecoration(

          borderRadius:
              BorderRadius.circular(
                  32),

          color: isDark

              ? const Color(
                  0xFF111827)

              : Colors.white,

          border: Border.all(

            color: isDark

                ? Colors.white
                    .withOpacity(
                        0.04)

                : Colors.black
                    .withOpacity(
                        0.03),
          ),

          boxShadow: [

            BoxShadow(

              color:
                  Colors.black
                      .withOpacity(
                0.08,
              ),

              blurRadius:
                  28,

              offset:
                  const Offset(
                0,
                12,
              ),
            ),
          ],
        ),

        child: Row(

          children: List.generate(

            icons.length,

            (index) {

              final isSelected =
                  currentIndex ==
                      index;

              return Expanded(

                child:
                    GestureDetector(

                  onTap: () {

                    setState(() {

                      currentIndex =
                          index;
                    });
                  },

                  child:
                      AnimatedContainer(

                    duration:
                        const Duration(
                      milliseconds:
                          250,
                    ),

                    padding:
                        const EdgeInsets.symmetric(

                      vertical: 14,

                      horizontal:
                          12,
                    ),

                    decoration:
                        BoxDecoration(

                      borderRadius:
                          BorderRadius.circular(
                              22),

                      gradient:
                          isSelected

                              ? const LinearGradient(
                                  colors: [

                                    Color(
                                        0xFF7C3AED),

                                    Color(
                                        0xFF06B6D4),
                                  ],
                                )

                              : null,
                    ),

                    child: Column(

                      mainAxisSize:
                          MainAxisSize.min,

                      children: [

                        AnimatedScale(

                          duration:
                              const Duration(
                            milliseconds:
                                250,
                          ),

                          scale:
                              isSelected
                                  ? 1.1
                                  : 1,

                          child: Icon(

                            icons[index],

                            color:
                                isSelected

                                    ? Colors.white

                                    : isDark

                                        ? Colors.white60

                                        : Colors.black54,

                            size: 28,
                          ),
                        ),

                        const SizedBox(
                            height:
                                8),

                        Text(

                          labels[index],

                          style:
                              TextStyle(

                            color:
                                isSelected

                                    ? Colors.white

                                    : isDark

                                        ? Colors.white60

                                        : Colors.black54,

                            fontSize:
                                13,

                            fontWeight:
                                FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}