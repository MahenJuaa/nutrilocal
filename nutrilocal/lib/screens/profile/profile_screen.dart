import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/theme_provider.dart';

import '../../widgets/app_section_title.dart';

import '../../widgets/app_card.dart';

import '../auth/login_screen.dart';

class ProfileScreen
    extends StatelessWidget {

  ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final themeProvider =
        context.watch<
            ThemeProvider>();

    final isDark =
        Theme.of(context)
                .brightness ==
            Brightness.dark;

    final textColor =
        isDark
            ? Colors.white
            : Colors.black87;

    final subtitleColor =
        isDark
            ? Colors.white60
            : Colors.black54;

    return Scaffold(

      backgroundColor:
          Theme.of(context)
              .scaffoldBackgroundColor,

      body: SafeArea(

        child: SingleChildScrollView(

          padding:
              const EdgeInsets.all(
                  24),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [

              const AppSectionTitle(

                title:
                    'My Profile',

                subtitle:
                    'Manage your account and preferences.',
              ),

              const SizedBox(
                  height: 30),

              AppCard(

                padding:
                    const EdgeInsets.all(
                        28),

                child: Row(

                  children: [

                    Container(

                      width: 100,
                      height: 100,

                      decoration:
                          BoxDecoration(

                        borderRadius:
                            BorderRadius.circular(
                                30),

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
                          const Icon(

                        Icons.person,

                        color:
                            Colors.white,

                        size: 52,
                      ),
                    ),

                    const SizedBox(
                        width:
                            20),

                    Expanded(

                      child: Column(

                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [

                          Text(

                            'NutriLocal User',

                            style:
                                TextStyle(

                              color:
                                  textColor,

                              fontSize:
                                  28,

                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(
                              height:
                                  8),

                          Text(

                            'AI Nutrition Explorer',

                            style:
                                TextStyle(

                              color:
                                  subtitleColor,

                              fontSize:
                                  16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                  height: 28),

              AppCard(

                child: Column(

                  children: [

                    buildMenuTile(

                      context:
                          context,

                      icon:
                          Icons.dark_mode,

                      title:
                          'Dark Mode',

                      subtitle:
                          'Switch application theme',

                      trailing:
                          Switch(

                        value:
                            themeProvider
                                .isDarkMode,

                        onChanged:
                            (value) {

                          themeProvider
                              .toggleTheme();
                        },
                      ),
                    ),

                    const Divider(
                        height:
                            34),

                    buildMenuTile(

                      context:
                          context,

                      icon:
                          Icons.notifications,

                      title:
                          'Notifications',

                      subtitle:
                          'Manage app notifications',
                    ),

                    const Divider(
                        height:
                            34),

                    buildMenuTile(

                      context:
                          context,

                      icon:
                          Icons.security,

                      title:
                          'Privacy & Security',

                      subtitle:
                          'Manage your privacy settings',
                    ),

                    const Divider(
                        height:
                            34),

                    buildMenuTile(

                      context:
                          context,

                      icon:
                          Icons.info,

                      title:
                          'About App',

                      subtitle:
                          'NutriLocal Health-Tech Prototype',
                    ),
                  ],
                ),
              ),

              const SizedBox(
                  height: 30),

              GestureDetector(

                onTap: () async {

                  final prefs =
                      await SharedPreferences
                          .getInstance();

                  await prefs.clear();

                  if (!context
                      .mounted) {
                    return;
                  }

                  Navigator.pushAndRemoveUntil(

                    context,

                    MaterialPageRoute(

                      builder:
                          (_) =>
                              LoginScreen(),
                    ),

                    (route) =>
                        false,
                  );
                },

                child: Container(

                  width:
                      double.infinity,

                  padding:
                      const EdgeInsets.symmetric(

                    vertical:
                        22,
                  ),

                  decoration:
                      BoxDecoration(

                    borderRadius:
                        BorderRadius.circular(
                            28),

                    gradient:
                        const LinearGradient(
                      colors: [

                        Color(
                            0xFFEF4444),

                        Color(
                            0xFFF97316),
                      ],
                    ),

                    boxShadow: [

                      BoxShadow(

                        color:
                            const Color(
                          0xFFEF4444,
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

                  child: const Row(

                    mainAxisAlignment:
                        MainAxisAlignment
                            .center,

                    children: [

                      Icon(

                        Icons.logout,

                        color:
                            Colors.white,
                      ),

                      SizedBox(
                          width:
                              12),

                      Text(

                        'Logout',

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
                    ],
                  ),
                ),
              ),

              const SizedBox(
                  height: 120),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuTile({

    required BuildContext
        context,

    required IconData icon,

    required String title,

    required String subtitle,

    Widget? trailing,

  }) {

    final isDark =
        Theme.of(context)
                .brightness ==
            Brightness.dark;

    return Row(

      children: [

        Container(

          width: 58,
          height: 58,

          decoration:
              BoxDecoration(

            borderRadius:
                BorderRadius.circular(
                    18),

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

          child: Icon(

            icon,

            color:
                Colors.white,
          ),
        ),

        const SizedBox(
            width: 18),

        Expanded(

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [

              Text(

                title,

                style: TextStyle(

                  color: isDark

                      ? Colors.white

                      : Colors.black87,

                  fontSize: 18,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                  height: 6),

              Text(

                subtitle,

                style: TextStyle(

                  color: isDark

                      ? Colors.white60

                      : Colors.black54,

                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),

        trailing ??

            Icon(

              Icons.chevron_right,

              color: isDark

                  ? Colors.white60

                  : Colors.black54,
            ),
      ],
    );
  }
}