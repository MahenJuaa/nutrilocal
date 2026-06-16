import 'package:flutter/material.dart';

import 'home/home_screen.dart';

import 'history/history_screen.dart';

import 'progress/progress_screen.dart';

import 'profile/profile_screen.dart';

import 'ai/ai_scanner_screen.dart';

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

    AiScannerScreen(),

    HistoryScreen(),

    ProgressScreen(),

    ProfileScreen(),
  ];

  final List<IconData> icons = [

    Icons.home_rounded,

    Icons.auto_awesome,

    Icons.history_rounded,

    Icons.analytics_rounded,

    Icons.person_rounded,
  ];

  final List<String> labels = [

    'Home',

    'AI Scan',

    'Logs',

    'Stats',

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

          18,
          0,
          18,
          20,
        ),

        padding:
            const EdgeInsets.symmetric(

          horizontal: 14,

          vertical: 8,
        ),

        decoration:
            BoxDecoration(

          borderRadius:
              BorderRadius.circular(
                  30),

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
                  24,

              offset:
                  const Offset(
                0,
                10,
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

                      vertical: 10,

                      horizontal:
                          8,
                    ),

                    decoration:
                        BoxDecoration(

                      borderRadius:
                          BorderRadius.circular(
                              20),

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
                                  ? 1.08
                                  : 1,

                          child: Icon(

                            icons[index],

                            color:
                                isSelected

                                    ? Colors.white

                                    : isDark

                                        ? Colors.white60

                                        : Colors.black54,

                            size: 24,
                          ),
                        ),

                        const SizedBox(
                            height:
                                6),

                        Text(

                          labels[index],

                          textAlign:
                              TextAlign.center,

                          style:
                              TextStyle(

                            color:
                                isSelected

                                    ? Colors.white

                                    : isDark

                                        ? Colors.white60

                                        : Colors.black54,

                            fontSize:
                                11,

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