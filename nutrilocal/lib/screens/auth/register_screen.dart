import 'package:flutter/material.dart';

import '../../core/api_state.dart';

import '../../services/api_service.dart';

class RegisterScreen
    extends StatefulWidget {

  RegisterScreen({
    super.key,
  });

  @override
  State<RegisterScreen>
      createState() =>
          _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  bool isLoading = false;

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

      body: Stack(

        children: [

          Positioned(

            top: -120,
            right: -80,

            child: Container(

              width: 260,
              height: 260,

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
          ),

          Positioned(

            bottom: -120,
            left: -80,

            child: Container(

              width: 280,
              height: 280,

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
          ),

          SafeArea(

            child:
                SingleChildScrollView(

              padding:
                  const EdgeInsets.all(
                      24),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  const SizedBox(
                      height:
                          40),

                  Center(

                    child: Container(

                      width: 140,
                      height: 140,

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
                              0.35,
                            ),

                            blurRadius:
                                30,

                            spreadRadius:
                                6,
                          ),
                        ],
                      ),

                      child:
                          const Icon(

                        Icons.person_add,

                        color:
                            Colors.white,

                        size: 72,
                      ),
                    ),
                  ),

                  const SizedBox(
                      height:
                          50),

                  Text(

                    'Create Account ✨',

                    style: TextStyle(

                      color: isDark

                          ? Colors.white

                          : Colors.black87,

                      fontSize: 40,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                      height:
                          14),

                  Text(

                    'Register and start building healthier nutrition habits with AI-powered tracking.',

                    style: TextStyle(

                      color: isDark

                          ? Colors.white60

                          : Colors.black54,

                      fontSize: 17,

                      height: 1.6,
                    ),
                  ),

                  const SizedBox(
                      height:
                          42),

                  buildInputField(

                    controller:
                        emailController,

                    hint:
                        'Email',

                    icon:
                        Icons.email,
                  ),

                  const SizedBox(
                      height:
                          22),

                  buildInputField(

                    controller:
                        passwordController,

                    hint:
                        'Password',

                    icon:
                        Icons.lock,

                    obscure:
                        true,
                  ),

                  const SizedBox(
                      height:
                          36),

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

                                  setState(() {

                                    isLoading =
                                        true;
                                  });

                                  final result =
                                      await ApiService
                                          .register(

                                    email:
                                        emailController
                                            .text,

                                    password:
                                        passwordController
                                            .text,
                                  );

                                  if (!mounted) {
                                    return;
                                  }

                                  setState(() {

                                    isLoading =
                                        false;
                                  });

                                  if (result.status ==
                                      ApiStatus.success) {

                                    ScaffoldMessenger.of(
                                            context)
                                        .showSnackBar(

                                      const SnackBar(

                                        content:
                                            Text(
                                          'Registration successful',
                                        ),
                                      ),
                                    );

                                    Navigator.pop(
                                        context);
                                  }

                                  else {

                                    ScaffoldMessenger.of(
                                            context)
                                        .showSnackBar(

                                      SnackBar(

                                        content:
                                            Text(

                                          result.message ??
                                              'Registration failed',
                                        ),
                                      ),
                                    );
                                  }
                                },

                      child:
                          isLoading

                              ? const CircularProgressIndicator(
                                  color:
                                      Colors.white,
                                )

                              : const Text(

                                  'Register',

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
                      height:
                          28),

                  Row(

                    mainAxisAlignment:
                        MainAxisAlignment
                            .center,

                    children: [

                      Text(

                        'Already have an account?',

                        style:
                            TextStyle(

                          color: isDark

                              ? Colors.white60

                              : Colors.black54,
                        ),
                      ),

                      TextButton(

                        onPressed:
                            () {

                          Navigator.pop(
                              context);
                        },

                        child: const Text(

                          'Login',

                          style:
                              TextStyle(

                            color:
                                Color(
                                    0xFF7C3AED),

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInputField({

    required TextEditingController
        controller,

    required String hint,

    required IconData icon,

    bool obscure = false,

  }) {

    final isDark =
        Theme.of(context)
                .brightness ==
            Brightness.dark;

    return TextField(

      controller: controller,

      obscureText: obscure,

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
}