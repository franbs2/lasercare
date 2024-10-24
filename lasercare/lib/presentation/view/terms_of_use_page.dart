import 'package:flutter/material.dart';
import 'package:lasercare/core/app_colors.dart';

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tertiaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.tertiaryColor,
        title: const Text('Termos de Uso'),
      ),
      body: const Center(
        child: Text('Termos de Uso'),
      ),
    );
  }
}
