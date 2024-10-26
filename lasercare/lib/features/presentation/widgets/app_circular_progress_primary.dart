import 'package:flutter/material.dart';
import '/core/style/app_colors.dart';

class AppCircularProgressPrimary extends StatelessWidget {
  const AppCircularProgressPrimary({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: AppColors.primaryColor,
      valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondaryColor),
    );
  }
}
