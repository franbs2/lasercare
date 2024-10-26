import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/style/app_colors.dart';

class AppTextForm extends StatefulWidget {
  final String labelText;
  final FontWeight fontWeight;
  final IconData prefixIcon;
  final Color colorBorder;
  final Color colorIcon;
  final Color cursorColor;
  final Color colorLabel;
  final double fontSize;
  final double borderRadiusValue;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool isPassword;
  final String hintText;
  final List<TextInputFormatter> inputFormatters;

  const AppTextForm({
    super.key,
    required this.labelText,
    required this.prefixIcon,
    this.fontWeight = FontWeight.w500,
    this.colorBorder = const Color(0xff316e75),
    this.cursorColor = const Color(0xff316e75),
    this.colorIcon = const Color(0xff97b5b9),
    this.colorLabel = Colors.grey,
    this.fontSize = 14,
    this.borderRadiusValue = 12,
    this.controller,
    this.validator,
    this.isPassword = false,
    this.hintText = '',
    this.inputFormatters = const [],
  });

  @override
  State<AppTextForm> createState() => _AppTextFormState();
}

class _AppTextFormState extends State<AppTextForm> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: widget.inputFormatters,
      cursorColor: widget.cursorColor,
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: widget.colorLabel,
          fontSize: widget.fontSize,
        ),
        prefixIcon: Icon(widget.prefixIcon, color: widget.colorIcon),
        labelText: widget.labelText,
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(widget.borderRadiusValue)),
          borderSide: BorderSide(color: widget.colorBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(widget.borderRadiusValue)),
          borderSide: BorderSide(color: widget.colorBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(widget.borderRadiusValue)),
          borderSide: BorderSide(color: widget.colorBorder),
        ),
        labelStyle: TextStyle(
          color: widget.colorLabel,
          fontSize: widget.fontSize,
          fontWeight: widget.fontWeight,
        ),
        suffixIcon: (widget.isPassword)
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.secondaryColor,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
