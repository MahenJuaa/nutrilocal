import 'package:flutter/material.dart';

class AchievementCard
    extends StatelessWidget {

  final int streakDays;

  final String achievement;

  const AchievementCard({

    super.key,

    required this.streakDays,

    required this.achievement,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      width: double.infinity,

      padding:
          const EdgeInsets.all(28),

      decoration: BoxDecoration(

        borderRadius:
            BorderRadius.circular(
                30),

        gradient:
            const LinearGradient(
          colors: [

            Color(0xFFFF8A00),

            Color(0xFFFF3D54),
          ],
        ),

        boxShadow: [

          BoxShadow(

            color:
                Colors.orange
                    .withOpacity(0.35),

            blurRadius: 20,

            spreadRadius: 2,
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(

            children: [

              Container(

                padding:
                    const EdgeInsets.all(
                        16),

                decoration:
                    BoxDecoration(

                  color: Colors.white24,

                  borderRadius:
                      BorderRadius.circular(
                          20),
                ),

                child: const Icon(

                  Icons.emoji_events,

                  color: Colors.white,

                  size: 34,
                ),
              ),

              const SizedBox(width: 18),

              Expanded(

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    const Text(

                      'Current Achievement',

                      style: TextStyle(

                        color:
                            Colors.white70,

                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(

                      achievement,

                      style:
                          const TextStyle(

                        color:
                            Colors.white,

                        fontSize: 24,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          Container(

            padding:
                const EdgeInsets.all(
                    20),

            decoration: BoxDecoration(

              color: Colors.white12,

              borderRadius:
                  BorderRadius.circular(
                      24),
            ),

            child: Row(

              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,

              children: [

                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    const Text(

                      'Tracking Streak',

                      style: TextStyle(

                        color:
                            Colors.white70,

                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(

                      '$streakDays Days',

                      style:
                          const TextStyle(

                        color:
                            Colors.white,

                        fontSize: 32,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                Container(

                  padding:
                      const EdgeInsets.all(
                          18),

                  decoration:
                      BoxDecoration(

                    shape: BoxShape.circle,

                    color: Colors.white24,
                  ),

                  child: const Icon(

                    Icons.local_fire_department,

                    color: Colors.white,

                    size: 40,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Text(

            'Maintain your nutrition consistency daily to unlock higher achievement levels and better health progress 🚀',

            style: TextStyle(

              color: Colors.white,

              height: 1.5,

              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}