import 'dart:async';

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';

import 'package:flutter/foundation.dart';

import '../../providers/nutrition_provider.dart';

import '../../services/api_service.dart';

class AiScannerScreen
    extends StatefulWidget {

  const AiScannerScreen({
    super.key,
  });

  @override
  State<AiScannerScreen>
      createState() =>
          _AiScannerScreenState();
}

class _AiScannerScreenState
    extends State<
        AiScannerScreen>
    with
        TickerProviderStateMixin {

  bool isScanning = false;

  bool showResult = false;

  String scanningText =
      'Initializing AI...';

  late AnimationController
      scanController;

  late Animation<double>
      scanAnimation;

  String detectedFood =
      '';

  int detectedCalories =
      0;

  String protein =
      '';

  String carbs =
      '';

  String fat =
      '';

  XFile? selectedImage;

  final ImagePicker picker =
      ImagePicker();

  @override
  void initState() {

    super.initState();

    scanController =
        AnimationController(

      vsync: this,

      duration:
          const Duration(
        seconds: 2,
      ),
    )..repeat(
            reverse: true);

    scanAnimation =
        Tween<double>(

      begin: -120,

      end: 180,
    ).animate(

      CurvedAnimation(

        parent:
            scanController,

        curve:
            Curves.linear,
      ),
    );
  }

  @override
  void dispose() {

    scanController.dispose();

    super.dispose();
  }

  Future<void>
      pickImage() async {

    final XFile? image =
        await picker.pickImage(

      source:
          ImageSource.gallery,
    );

    if (image == null) {
      return;
    }

    setState(() {

      selectedImage =
          image;

      showResult = false;
    });
  }

  Future<void>
      startScanning() async {

    if (selectedImage ==
        null) {

      ScaffoldMessenger.of(
              context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            'Please choose an image first',
          ),
        ),
      );

      return;
    }

    setState(() {

      isScanning = true;

      showResult = false;

      scanningText =
          'Uploading Image...';
    });

    await Future.delayed(

      const Duration(
        milliseconds: 900,
      ),
    );

    if (!mounted) {
      return;
    }

    setState(() {

      scanningText =
          'Detecting Food Object...';
    });

    await Future.delayed(

      const Duration(
        milliseconds: 1200,
      ),
    );

    if (!mounted) {
      return;
    }

    setState(() {

      scanningText =
          'Matching Nutrition Database...';
    });

    final response =
        await ApiService
            .scanFoodImage(

      imageFile:
          selectedImage!,
    );

    if (!mounted) {
      return;
    }

    if (response.data !=
        null) {

      final data =
          response.data;

      setState(() {

        detectedFood =
            data['name']
                .toString();

        detectedCalories =
            (data['calories']
                    as num)
                .toInt();

        protein =
            '${data['protein']}g';

        carbs =
            '${data['carbs']}g';

        fat =
            '${data['fat']}g';

        isScanning = false;

        showResult = true;
      });
    }

    else {

      setState(() {

        isScanning = false;

        showResult = false;
      });

      ScaffoldMessenger.of(
              context)
          .showSnackBar(

        const SnackBar(

          backgroundColor:
              Colors.red,

          content: Text(

            'AI failed to recognize food',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final nutritionProvider =
        context.watch<
            NutritionProvider>();

    final isDark =
        Theme.of(context)
                .brightness ==
            Brightness.dark;

    return Scaffold(

      backgroundColor:
          Theme.of(context)
              .scaffoldBackgroundColor,

      appBar: AppBar(

        title: const Text(
          'AI Food Scanner',
        ),
      ),

      body:
          SingleChildScrollView(

        padding:
            const EdgeInsets.all(
                20),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment
                  .start,

          children: [

            Container(

              width:
                  double.infinity,

              padding:
                  const EdgeInsets.all(
                      24),

              decoration:
                  BoxDecoration(

                borderRadius:
                    BorderRadius.circular(
                        28),

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
                        22,

                    offset:
                        const Offset(
                      0,
                      10,
                    ),
                  ),
                ],
              ),

              child: const Column(

                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  Icon(

                    Icons.auto_awesome,

                    color:
                        Colors.white,

                    size: 48,
                  ),

                  SizedBox(
                      height:
                          18),

                  Text(

                    'AI Nutrition Detection',

                    style: TextStyle(

                      color:
                          Colors.white,

                      fontSize:
                          26,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  SizedBox(
                      height:
                          10),

                  Text(

                    'Scan campus food instantly and get automatic calorie estimation using AI.',

                    style: TextStyle(

                      color:
                          Colors.white70,

                      fontSize:
                          15,

                      height:
                          1.6,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
                height: 28),

            Container(

              width:
                  double.infinity,

              height: 280,

              decoration:
                  BoxDecoration(

                borderRadius:
                    BorderRadius.circular(
                        34),

                color: isDark

                    ? const Color(
                        0xFF111827)

                    : Colors.white,

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

              child: Stack(

                alignment:
                    Alignment.center,

                children: [

                  Container(

                    margin:
                        const EdgeInsets.all(
                            14),

                    decoration:
                        BoxDecoration(

                      borderRadius:
                          BorderRadius.circular(
                              28),

                      border: Border.all(

                        color:
                            const Color(
                          0xFF06B6D4,
                        ).withOpacity(
                          0.35,
                        ),

                        width: 2,
                      ),
                    ),

                    child: ClipRRect(

                      borderRadius:
                          BorderRadius.circular(
                              26),

                      child: Stack(

                        fit:
                            StackFit.expand,

                        children: [

                          selectedImage !=
                                  null

                              ? (kIsWeb

                                  ? Image.network(

                                      selectedImage!
                                          .path,

                                      fit:
                                          BoxFit.cover,
                                    )

                                  : Image.file(

                                      File(
                                        selectedImage!
                                            .path,
                                      ),

                                      fit:
                                          BoxFit.cover,
                                    ))

                              : Image.asset(

                                  'assets/images/food.jpg',

                                  fit:
                                      BoxFit.cover,
                                ),

                          Container(

                            decoration:
                                BoxDecoration(

                              gradient:
                                  LinearGradient(

                                begin:
                                    Alignment.topCenter,

                                end:
                                    Alignment.bottomCenter,

                                colors: [

                                  Colors.black
                                      .withOpacity(
                                    0.15,
                                  ),

                                  Colors.black
                                      .withOpacity(
                                    0.35,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Positioned(

                            top: 16,

                            left: 16,

                            child: Container(

                              padding:
                                  const EdgeInsets.symmetric(

                                horizontal:
                                    12,

                                vertical:
                                    6,
                              ),

                              decoration:
                                  BoxDecoration(

                                color:
                                    Colors.black
                                        .withOpacity(
                                  0.6,
                                ),

                                borderRadius:
                                    BorderRadius.circular(
                                        14),
                              ),

                              child:
                                  const Row(

                                children: [

                                  Icon(

                                    Icons.circle,

                                    color:
                                        Colors.red,

                                    size: 10,
                                  ),

                                  SizedBox(
                                      width:
                                          8),

                                  Text(

                                    'AI LIVE',

                                    style:
                                        TextStyle(

                                      color:
                                          Colors.white,

                                      fontSize:
                                          12,

                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  if (isScanning)

                    AnimatedBuilder(

                      animation:
                          scanAnimation,

                      builder:
                          (
                            context,
                            child,
                          ) {

                        return Positioned(

                          top:
                              scanAnimation
                                  .value,

                          child:
                              Container(

                            width:
                                240,

                            height:
                                4,

                            decoration:
                                BoxDecoration(

                              borderRadius:
                                  BorderRadius.circular(
                                      12),

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
                          ),
                        );
                      },
                    ),

                  if (isScanning)

                    Container(

                      width: 240,
                      height: 240,

                      decoration:
                          BoxDecoration(

                        borderRadius:
                            BorderRadius.circular(
                                28),

                        border:
                            Border.all(

                          color:
                              const Color(
                            0xFF06B6D4,
                          ),

                          width: 3,
                        ),
                      ),
                    ),

                  if (isScanning)

                    Positioned(

                      bottom: 28,

                      child: Container(

                        padding:
                            const EdgeInsets.symmetric(

                          horizontal:
                              22,

                          vertical:
                              14,
                        ),

                        decoration:
                            BoxDecoration(

                          color:
                              Colors.black
                                  .withOpacity(
                            0.72,
                          ),

                          borderRadius:
                              BorderRadius.circular(
                                  20),
                        ),

                        child: Row(

                          children: [

                            const SizedBox(

                              width: 18,
                              height: 18,

                              child:
                                  CircularProgressIndicator(

                                strokeWidth:
                                    2,

                                color:
                                    Colors.white,
                              ),
                            ),

                            const SizedBox(
                                width:
                                    14),

                            Text(

                              scanningText,

                              style:
                                  const TextStyle(

                                color:
                                    Colors.white,

                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(
                height: 24),

            SizedBox(

              width:
                  double.infinity,

              height: 58,

              child:
                  OutlinedButton.icon(

                style:
                    OutlinedButton.styleFrom(

                  side:
                      const BorderSide(

                    color:
                        Color(
                      0xFF7C3AED,
                    ),
                  ),

                  shape:
                      RoundedRectangleBorder(

                    borderRadius:
                        BorderRadius.circular(
                            20),
                  ),
                ),

                onPressed:
                    pickImage,

                icon:
                    const Icon(
                  Icons.photo,
                ),

                label:
                    const Text(
                  'Choose From Gallery',
                ),
              ),
            ),

            const SizedBox(
                height: 18),

            SizedBox(

              width:
                  double.infinity,

              height: 64,

              child:
                  ElevatedButton(

                style:
                    ElevatedButton.styleFrom(

                  backgroundColor:
                      const Color(
                    0xFF7C3AED,
                  ),

                  shape:
                      RoundedRectangleBorder(

                    borderRadius:
                        BorderRadius.circular(
                            22),
                  ),
                ),

                onPressed:
                    isScanning

                        ? null

                        : startScanning,

                child:
                    Text(

                  isScanning

                      ? 'Analyzing Food...'

                      : 'Start AI Scan',

                  style:
                      const TextStyle(

                    color:
                        Colors.white,

                    fontSize:
                        18,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(
                height: 32),

            if (showResult)

              Container(

                width:
                    double.infinity,

                padding:
                    const EdgeInsets.all(
                        24),

                decoration:
                    BoxDecoration(

                  borderRadius:
                      BorderRadius.circular(
                          28),

                  color: isDark

                      ? const Color(
                          0xFF111827)

                      : Colors.white,

                  boxShadow: [

                    BoxShadow(

                      color:
                          Colors.black
                              .withOpacity(
                        0.06,
                      ),

                      blurRadius:
                          18,

                      offset:
                          const Offset(
                        0,
                        10,
                      ),
                    ),
                  ],
                ),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    const Row(

                      children: [

                        Icon(

                          Icons.check_circle,

                          color:
                              Colors.green,

                          size: 28,
                        ),

                        SizedBox(
                            width:
                                12),

                        Text(

                          'AI Detection Result',

                          style:
                              TextStyle(

                            fontSize:
                                22,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                        height:
                            24),

                    buildInfo(
                      'Detected Food',
                      detectedFood,
                    ),

                    buildInfo(
                      'Estimated Calories',
                      '$detectedCalories kcal',
                    ),

                    buildInfo(
                      'Protein',
                      protein,
                    ),

                    buildInfo(
                      'Carbohydrate',
                      carbs,
                    ),

                    buildInfo(
                      'Fat',
                      fat,
                    ),

                    const SizedBox(
                        height:
                            20),

                    Container(

                      width:
                          double.infinity,

                      padding:
                          const EdgeInsets.all(
                              18),

                      decoration:
                          BoxDecoration(

                        borderRadius:
                            BorderRadius.circular(
                                20),

                        gradient:
                            LinearGradient(
                          colors: [

                            const Color(
                              0xFF7C3AED,
                            ).withOpacity(
                              0.15,
                            ),

                            const Color(
                              0xFF06B6D4,
                            ).withOpacity(
                              0.15,
                            ),
                          ],
                        ),
                      ),

                      child: const Text(

                        'AI Recommendation:\nBalance your meal with vegetables and hydration for healthier nutrition.',

                        style:
                            TextStyle(

                          fontSize:
                              15,

                          height:
                              1.7,

                          fontWeight:
                              FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(
                        height:
                            24),

                    SizedBox(

                      width:
                          double.infinity,

                      height: 58,

                      child:
                          ElevatedButton(

                        style:
                            ElevatedButton.styleFrom(

                          backgroundColor:
                              const Color(
                            0xFF7C3AED,
                          ),

                          shape:
                              RoundedRectangleBorder(

                            borderRadius:
                                BorderRadius.circular(
                                    20),
                          ),
                        ),

                        onPressed:
                            () async {

                          await nutritionProvider
                              .addMeal(

                            detectedFood,

                            detectedCalories,
                          );

                          if (!context
                              .mounted) {
                            return;
                          }

                          ScaffoldMessenger.of(
                                  context)
                              .showSnackBar(

                            const SnackBar(

                              content:
                                  Text(
                                'Food added to tracker',
                              ),
                            ),
                          );
                        },

                        child:
                            const Text(

                          'Add To Tracker',

                          style:
                              TextStyle(

                            color:
                                Colors.white,

                            fontSize:
                                17,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(
                height: 40),
          ],
        ),
      ),
    );
  }

  Widget buildInfo(

    String title,

    String value,

  ) {

    return Padding(

      padding:
          const EdgeInsets.only(
              bottom: 16),

      child: Row(

        mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,

        children: [

          Text(

            title,

            style:
                const TextStyle(

              fontSize: 15,

              fontWeight:
                  FontWeight.w500,
            ),
          ),

          Text(

            value,

            style:
                const TextStyle(

              fontSize: 17,

              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}