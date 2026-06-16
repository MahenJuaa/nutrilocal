import 'dart:async';

import 'package:flutter/material.dart';

import '../auth/login_screen.dart';

import '../main_screen.dart';

class SplashScreen
    extends StatefulWidget {

  final bool isLoggedIn;

  const SplashScreen({

    super.key,

    required this.isLoggedIn,
  });

  @override
  State<SplashScreen>
      createState() =>
          _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen>
    with
        TickerProviderStateMixin {

  late AnimationController
      logoController;

  late AnimationController
      glowController;

  late Animation<double>
      scaleAnimation;

  late Animation<double>
      glowAnimation;

  @override
  void initState() {

    super.initState();

    logoController =
        AnimationController(

      vsync: this,

      duration:
          const Duration(
        milliseconds: 1200,
      ),
    );

    glowController =
        AnimationController(

      vsync: this,

      duration:
          const Duration(
        milliseconds: 1800,
      ),
    )..repeat(
            reverse: true);

    scaleAnimation =
        CurvedAnimation(

      parent:
          logoController,

      curve:
          Curves.easeOutBack,
    );

    glowAnimation =
        Tween<double>(

      begin: 0.4,

      end: 1,
    ).animate(
      glowController,
    );

    logoController.forward();

    Timer(

      const Duration(
        seconds: 3,
      ),

      () {

        Navigator.pushReplacement(

          context,

          PageRouteBuilder(

            pageBuilder:
                (
                  context,
                  animation,
                  secondaryAnimation,
                ) =>

                    widget.isLoggedIn

                        ? MainScreen()

                        : LoginScreen(),

            transitionsBuilder:
                (
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                ) {

              return FadeTransition(

                opacity:
                    animation,

                child: child,
              );
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {

    logoController.dispose();

    glowController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        width:
            double.infinity,

        decoration:
            const BoxDecoration(

          gradient:
              LinearGradient(

            begin:
                Alignment.topLeft,

            end:
                Alignment.bottomRight,

            colors: [

              Color(
                  0xFF0F172A),

              Color(
                  0xFF1E1B4B),

              Color(
                  0xFF7C3AED),
            ],
          ),
        ),

        child: Stack(

          children: [

            Positioned(

              top: -120,
              right: -80,

              child:
                  AnimatedBuilder(

                animation:
                    glowAnimation,

                builder:
                    (
                      context,
                      child,
                    ) {

                  return Opacity(

                    opacity:
                        glowAnimation
                            .value,

                    child:
                        Container(

                      width: 260,
                      height: 260,

                      decoration:
                          BoxDecoration(

                        shape:
                            BoxShape.circle,

                        color:
                            const Color(
                          0xFF06B6D4,
                        ).withOpacity(
                          0.18,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Positioned(

              bottom: -120,
              left: -80,

              child:
                  AnimatedBuilder(

                animation:
                    glowAnimation,

                builder:
                    (
                      context,
                      child,
                    ) {

                  return Opacity(

                    opacity:
                        glowAnimation
                            .value,

                    child:
                        Container(

                      width: 300,
                      height: 300,

                      decoration:
                          BoxDecoration(

                        shape:
                            BoxShape.circle,

                        color:
                            const Color(
                          0xFF7C3AED,
                        ).withOpacity(
                          0.18,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SafeArea(

              child: Center(

                child: Column(

                  mainAxisAlignment:
                      MainAxisAlignment
                          .center,

                  children: [

                    ScaleTransition(

                      scale:
                          scaleAnimation,

                      child: Container(

                        width: 170,
                        height: 170,

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
                                0.45,
                              ),

                              blurRadius:
                                  40,

                              spreadRadius:
                                  10,
                            ),
                          ],
                        ),

                        child:
                            const Icon(

                          Icons.restaurant_menu,

                          color:
                              Colors.white,

                          size: 90,
                        ),
                      ),
                    ),

                    const SizedBox(
                        height:
                            44),

                    ShaderMask(

                      shaderCallback:
                          (bounds) {

                        return const LinearGradient(
                          colors: [

                            Colors.white,

                            Color(
                                0xFFE0E7FF),
                          ],
                        ).createShader(
                            bounds);
                      },

                      child: const Text(

                        'NutriLocal',

                        style: TextStyle(

                          color:
                              Colors.white,

                          fontSize:
                              48,

                          fontWeight:
                              FontWeight.bold,

                          letterSpacing:
                              1.2,
                        ),
                      ),
                    ),

                    const SizedBox(
                        height:
                            16),

                    const Padding(

                      padding:
                          EdgeInsets.symmetric(
                        horizontal:
                            32,
                      ),

                      child: Text(

                        'AI-powered nutrition assistant for healthier student lifestyles.',

                        textAlign:
                            TextAlign.center,

                        style: TextStyle(

                          color:
                              Colors.white70,

                          fontSize:
                              18,

                          height:
                              1.7,
                        ),
                      ),
                    ),

                    const SizedBox(
                        height:
                            60),

                    SizedBox(

                      width: 34,
                      height: 34,

                      child:
                          CircularProgressIndicator(

                        strokeWidth:
                            3,

                        valueColor:
                            const AlwaysStoppedAnimation(
                          Colors.white,
                        ),

                        backgroundColor:
                            Colors.white24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}