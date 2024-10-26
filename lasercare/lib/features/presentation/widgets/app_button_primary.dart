import 'package:flutter/material.dart';

class AppButtonPrimary extends StatelessWidget {
  final String textButton;
  final double height;
  final double width;
  final double radius;
  final Color colorButton;
  final Color colorText;
  final void Function()? onPressed;

  const AppButtonPrimary(
      {super.key,
      required this.textButton,
      this.height = 16,
      this.width = 0,
      this.radius = 12,
      this.colorButton = const Color(0xff316e75),
      this.colorText = const Color(0xfffcfcfc),
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: colorButton,
        padding: EdgeInsets.symmetric(vertical: height, horizontal: width),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child: Text(
        textButton,
        style: TextStyle(fontSize: 16, color: colorText),
      ),
    );
  }
}
