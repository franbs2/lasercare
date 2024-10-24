import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class AppAuthNavigation extends StatelessWidget {
  final String text;
  final String actionText;
  final VoidCallback onPressed;

  const AppAuthNavigation({
    super.key,
    required this.text,
    required this.actionText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: const TextStyle(fontSize: 14)),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          onPressed: onPressed,
          child: Text(
            actionText,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
