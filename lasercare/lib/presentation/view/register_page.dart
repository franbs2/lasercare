import 'package:flutter/material.dart';
import 'package:lasercare/core/app_colors.dart';
import 'package:lasercare/core/app_formatter_input.dart';
import 'package:lasercare/core/app_images.dart';
import 'package:lasercare/core/app_strings.dart';
import 'package:lasercare/presentation/widgets/app_auth_navigation.dart';
import 'package:lasercare/presentation/widgets/app_button_primary.dart';
import 'package:lasercare/presentation/widgets/app_text_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool value = false;
  final cnpjFormatter = AppFormatterInput.cnpjFormatter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tertiaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.curativeLogo, width: 68, height: 68),
                const SizedBox(height: 32),
                const Text(
                  AppStrings.registerYourClinic,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Form(
                  key: _keyForm,
                  child: Column(
                    children: [
                      AppTextForm(
                        controller: _nameController,
                        labelText: AppStrings.nameClinic,
                        prefixIcon: Icons.business,
                        hintText: AppStrings.nameClinicExample,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.requiredField;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      AppTextForm(
                        controller: _cnpjController,
                        labelText: AppStrings.cnpj,
                        prefixIcon: Icons.business_center,
                        hintText: AppStrings.cnpjExample,
                        inputFormatters: [cnpjFormatter],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.requiredField;
                          } else if (value.length < 18) {
                            return AppStrings.invalidCnpj;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      AppTextForm(
                        controller: _emailController,
                        labelText: AppStrings.email,
                        prefixIcon: Icons.email,
                        hintText: AppStrings.emailExample,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.requiredField;
                          } else if (!value.contains('@')) {
                            return AppStrings.invalidEmail;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      AppTextForm(
                        controller: _passwordController,
                        labelText: AppStrings.password,
                        prefixIcon: Icons.lock,
                        isPassword: true,
                        hintText: AppStrings.minimumCharacters,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.requiredField;
                          } else if (value.length < 8) {
                            return AppStrings.shortPassword;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      AppTextForm(
                        controller: _confirmPasswordController,
                        labelText: AppStrings.confirmPass,
                        prefixIcon: Icons.lock,
                        isPassword: true,
                        hintText: AppStrings.confirmPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.requiredField;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Transform.scale(
                            scale: 0.8,
                            child: Checkbox(
                              checkColor: Colors.white,
                              activeColor: AppColors.primaryColor,
                              value: value,
                              onChanged: (newValue) {
                                setState(() {
                                  value = newValue ?? false;
                                });
                              },
                            ),
                          ),
                          const Text(AppStrings.aceptThe,
                              style: TextStyle(fontSize: 12)),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () {},
                            child: const Text(
                              AppStrings.termsOfUse,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: SizedBox(
                      width: double.infinity,
                      child: AppButtonPrimary(
                        textButton: AppStrings.register,
                        onPressed: () {},
                      )),
                ),
                const SizedBox(height: 4),
                AppAuthNavigation(
                    text: AppStrings.alreadyHaveAnAccount,
                    actionText: AppStrings.login,
                    onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
