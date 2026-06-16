import 'package:flutter/material.dart';

class QuickActionButton extends StatelessWidget {

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const QuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: GestureDetector(

        onTap: onTap,

        child: Container(

          padding: const EdgeInsets.symmetric(vertical: 20),

          decoration: BoxDecoration(

            gradient: const LinearGradient(
              colors: [
                Color(0xFF7C3AED),
                Color(0xFF06B6D4),
              ],
            ),

            borderRadius: BorderRadius.circular(20),
          ),

          child: Column(
            children: [

              Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),

              const SizedBox(height: 10),

              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}