import 'package:flutter/material.dart';

import '../main_screen.dart';

import '../../utils/page_transition.dart';

class OnboardingScreen
    extends StatefulWidget {

  const OnboardingScreen({
    super.key,
  });

  @override
  State<OnboardingScreen>
      createState() =>
          _OnboardingScreenState();
}

class _OnboardingScreenState
    extends State<
        OnboardingScreen> {

  final PageController
      controller =
          PageController();

  int currentPage = 0;

  final List<Map<String, dynamic>>
      pages = [

    {

      'icon':
          Icons.restaurant_menu,

      'title':
          'Track Your Nutrition',

      'description':
          'Monitor calories, meals, and daily nutrition easily with AI-powered tracking.',
    },

    {

      'icon':
          Icons.bar_chart,

      'title':
          'Analyze Your Progress',

      'description':
          'View beautiful analytics, calorie trends, hydration, and body health progress.',
    },

    {

      'icon':
          Icons.auto_awesome,

      'title':
          'Healthy Lifestyle',

      'description':
          'Build healthy habits and achieve your fitness goals with smart insights.',
    },
  ];

  void nextPage() {

    if (currentPage <
        pages.length - 1) {

      controller.nextPage(

        duration:
            const Duration(
          milliseconds: 350,
        ),

        curve:
            Curves.easeInOut,
      );

    } else {

      Navigator.pushReplacement(

        context,

        PageTransition(

          page:
              const MainScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final isDark =
        Theme.of(context)
                .brightness ==
            Brightness.dark;

    return Scaffold(

      backgroundColor:
          Theme.of(context)
              .scaffoldBackgroundColor,

      body: SafeArea(

        child: Padding(

          padding:
              const EdgeInsets.all(
                  24),

          child: Column(

            children: [

              Align(

                alignment:
                    Alignment
                        .centerRight,

                child: TextButton(

                  onPressed: () {

                    Navigator.pushReplacement(

                      context,

                      PageTransition(

                        page:
                            const MainScreen(),
                      ),
                    );
                  },

                  child: Text(

                    'Skip',

                    style: TextStyle(

                      color: isDark

                          ? Colors
                              .white70

                          : Colors
                              .black54,

                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              Expanded(

                child: PageView.builder(

                  controller:
                      controller,

                  itemCount:
                      pages.length,

                  onPageChanged:
                      (value) {

                    setState(() {

                      currentPage =
                          value;
                    });
                  },

                  itemBuilder:
                      (context,
                          index) {

                    final page =
                        pages[index];

                    return Column(

                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,

                      children: [

                        Container(

                          width: 240,
                          height: 240,

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
                                            0xFF7C3AED)
                                        .withOpacity(
                                            0.3),

                                blurRadius:
                                    40,
                              ),
                            ],
                          ),

                          child: Icon(

                            page['icon'],

                            color:
                                Colors.white,

                            size: 110,
                          ),
                        ),

                        const SizedBox(
                            height:
                                60),

                        Text(

                          page['title'],

                          textAlign:
                              TextAlign
                                  .center,

                          style:
                              TextStyle(

                            color:
                                isDark

                                    ? Colors
                                        .white

                                    : Colors
                                        .black87,

                            fontSize:
                                34,

                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),

                        const SizedBox(
                            height:
                                24),

                        Padding(

                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),

                          child: Text(

                            page[
                                'description'],

                            textAlign:
                                TextAlign
                                    .center,

                            style:
                                TextStyle(

                              color:
                                  isDark

                                      ? Colors
                                          .white70

                                      : Colors
                                          .black54,

                              fontSize:
                                  18,

                              height:
                                  1.7,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              Row(

                mainAxisAlignment:
                    MainAxisAlignment
                        .center,

                children:
                    List.generate(

                  pages.length,

                  (index) {

                    final active =
                        currentPage ==
                            index;

                    return AnimatedContainer(

                      duration:
                          const Duration(
                        milliseconds:
                            300,
                      ),

                      margin:
                          const EdgeInsets.symmetric(
                        horizontal: 6,
                      ),

                      width:
                          active
                              ? 34
                              : 12,

                      height: 12,

                      decoration:
                          BoxDecoration(

                        borderRadius:
                            BorderRadius.circular(
                                20),

                        gradient:
                            active

                                ? const LinearGradient(
                                    colors: [

                                      Color(
                                          0xFF7C3AED),

                                      Color(
                                          0xFF06B6D4),
                                    ],
                                  )

                                : null,

                        color:
                            active

                                ? null

                                : Colors.grey
                                    .withOpacity(
                                        0.4),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(

                width: double.infinity,

                height: 64,

                child: ElevatedButton(

                  onPressed:
                      nextPage,

                  style:
                      ElevatedButton.styleFrom(

                    padding:
                        EdgeInsets.zero,

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(
                              24),
                    ),
                  ),

                  child: Ink(

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

                    child: Container(

                      alignment:
                          Alignment.center,

                      child: Text(

                        currentPage ==
                                pages.length -
                                    1

                            ? 'Get Started'

                            : 'Next',

                        style:
                            const TextStyle(

                          color:
                              Colors.white,

                          fontSize: 20,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}