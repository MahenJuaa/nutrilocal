import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class EditProfileSheet
    extends StatefulWidget {

  const EditProfileSheet({
    super.key,
  });

  @override
  State<EditProfileSheet>
      createState() =>
          _EditProfileSheetState();
}

class _EditProfileSheetState
    extends State<EditProfileSheet> {

  late TextEditingController
      usernameController;

  late TextEditingController
      bioController;

  @override
  void initState() {
    super.initState();

    final userProvider =
        context.read<UserProvider>();

    usernameController =
        TextEditingController(

      text: userProvider.username,
    );

    bioController =
        TextEditingController(

      text: userProvider.bio,
    );
  }

  @override
  void dispose() {

    usernameController.dispose();

    bioController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final userProvider =
        context.watch<UserProvider>();

    return Container(

      padding:
          const EdgeInsets.all(28),

      decoration: const BoxDecoration(

        color: Color(0xFF121826),

        borderRadius:
            BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),

      child: SingleChildScrollView(

        child: Column(

          mainAxisSize:
              MainAxisSize.min,

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Center(

              child: Container(

                width: 70,
                height: 6,

                decoration:
                    BoxDecoration(

                  color: Colors.white24,

                  borderRadius:
                      BorderRadius.circular(
                          20),
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(

              'Edit Profile',

              style: TextStyle(

                color: Colors.white,

                fontSize: 28,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(

              'Customize your profile information',

              style: TextStyle(
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 35),

            const Text(

              'Username',

              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 14),

            TextField(

              controller:
                  usernameController,

              style: const TextStyle(
                color: Colors.white,
              ),

              decoration: InputDecoration(

                hintText:
                    'Enter username',

                hintStyle:
                    const TextStyle(
                  color: Colors.white54,
                ),

                filled: true,

                fillColor:
                    const Color(
                        0xFF1E293B),

                border:
                    OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(
                          22),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 28),

            const Text(

              'Bio',

              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 14),

            TextField(

              controller:
                  bioController,

              maxLines: 3,

              style: const TextStyle(
                color: Colors.white,
              ),

              decoration: InputDecoration(

                hintText:
                    'Write something about yourself',

                hintStyle:
                    const TextStyle(
                  color: Colors.white54,
                ),

                filled: true,

                fillColor:
                    const Color(
                        0xFF1E293B),

                border:
                    OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(
                          22),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                onPressed: () async {

                  await userProvider
                      .updateProfile(

                    newUsername:
                        usernameController
                            .text,

                    newBio:
                        bioController
                            .text,
                  );

                  if (!context.mounted) {
                    return;
                  }

                  Navigator.pop(context);

                  ScaffoldMessenger.of(
                          context)
                      .showSnackBar(

                    const SnackBar(

                      backgroundColor:
                          Colors.green,

                      content: Text(
                        'Profile updated successfully',
                      ),
                    ),
                  );
                },

                style:
                    ElevatedButton.styleFrom(

                  backgroundColor:
                      const Color(
                          0xFF7C3AED),

                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 18,
                  ),

                  shape:
                      RoundedRectangleBorder(

                    borderRadius:
                        BorderRadius.circular(
                            20),
                  ),
                ),

                child: const Text(

                  'Save Profile',

                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}