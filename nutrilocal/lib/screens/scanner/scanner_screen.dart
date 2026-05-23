import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() =>
      _ScannerScreenState();
}

class _ScannerScreenState
    extends State<ScannerScreen> {

  File? image;

  String detectedFood =
      'No food detected';

  int calories = 0;

  Future<void> pickImage() async {

    final pickedFile =
        await ImagePicker().pickImage(

      source: ImageSource.gallery,
    );

    if (pickedFile == null) return;

    setState(() {

      image = File(pickedFile.path);
    });

    fakeAiDetection();
  }

  void fakeAiDetection() {

    final foods = [

      {
        'name': 'Nasi Goreng',
        'calories': 450,
      },

      {
        'name': 'Ayam Geprek',
        'calories': 520,
      },

      {
        'name': 'Soto Ayam',
        'calories': 320,
      },

      {
        'name': 'Bakso',
        'calories': 390,
      },

      {
        'name': 'Gado-Gado',
        'calories': 280,
      },
    ];

    foods.shuffle();

    final food = foods.first;

    Future.delayed(
      const Duration(seconds: 1),
      () {

        setState(() {

          detectedFood =
              food['name'].toString();

          calories =
              food['calories'] as int;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFF0F172A),

      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const Text(
                'AI Food Scanner',

                style: TextStyle(
                  color: Colors.white,

                  fontSize: 30,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Upload food image for AI detection',

                style: TextStyle(
                  color: Colors.white70,

                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 30),

              Expanded(

                child: Container(

                  width: double.infinity,

                  decoration: BoxDecoration(

                    color:
                        const Color(0xFF1E293B),

                    borderRadius:
                        BorderRadius.circular(30),
                  ),

                  child: image == null

                      ? Column(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .center,

                          children: [

                            const Icon(
                              Icons.camera_alt,

                              color:
                                  Colors.white70,

                              size: 100,
                            ),

                            const SizedBox(
                                height: 30),

                            const Text(
                              'No image selected',

                              style: TextStyle(
                                color:
                                    Colors.white70,

                                fontSize: 18,
                              ),
                            ),

                            const SizedBox(
                                height: 40),

                            ElevatedButton(

                              onPressed:
                                  pickImage,

                              style:
                                  ElevatedButton.styleFrom(

                                backgroundColor:
                                    const Color(
                                        0xFF7C3AED),

                                padding:
                                    const EdgeInsets.symmetric(

                                  horizontal: 40,

                                  vertical: 18,
                                ),
                              ),

                              child: const Text(

                                'Choose Image',

                                style: TextStyle(
                                  color:
                                      Colors.white,

                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        )

                      : Column(

                          children: [

                            Expanded(

                              child: ClipRRect(

                                borderRadius:
                                    const BorderRadius.only(

                                  topLeft:
                                      Radius.circular(
                                          30),

                                  topRight:
                                      Radius.circular(
                                          30),
                                ),

                                child: Image.file(

                                  image!,

                                  width:
                                      double.infinity,

                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            Padding(

                              padding:
                                  const EdgeInsets.all(
                                      24),

                              child: Column(

                                children: [

                                  Text(
                                    detectedFood,

                                    style:
                                        const TextStyle(
                                      color:
                                          Colors.white,

                                      fontSize: 28,

                                      fontWeight:
                                          FontWeight
                                              .bold,
                                    ),
                                  ),

                                  const SizedBox(
                                      height: 12),

                                  Text(
                                    '$calories kcal',

                                    style:
                                        const TextStyle(
                                      color: Colors
                                          .white70,

                                      fontSize: 18,
                                    ),
                                  ),

                                  const SizedBox(
                                      height: 30),

                                  SizedBox(

                                    width:
                                        double.infinity,

                                    child:
                                        ElevatedButton(

                                      onPressed:
                                          pickImage,

                                      style:
                                          ElevatedButton.styleFrom(

                                        backgroundColor:
                                            const Color(
                                                0xFF7C3AED),

                                        padding:
                                            const EdgeInsets.symmetric(

                                          vertical:
                                              18,
                                        ),
                                      ),

                                      child:
                                          const Text(

                                        'Scan Another',

                                        style:
                                            TextStyle(
                                          color: Colors
                                              .white,

                                          fontSize:
                                              16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
    );
  }
}