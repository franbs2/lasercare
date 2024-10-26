import 'package:flutter/material.dart';

import '../../../core/ultils/app_formatter_input.dart';
import '../../../core/ultils/app_images.dart';
import '/core/style/app_colors.dart';
import '/core/ultils/app_strings.dart';
import '/features/presentation/widgets/app_auth_navigation.dart';
import '/features/presentation/widgets/app_button_primary.dart';
import '/features/presentation/widgets/app_text_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final cnpjFormatter = AppFormatterInput.cnpjFormatter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tertiaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.curativeLogo, width: 68, height: 68),
                const SizedBox(height: 32),
                const Text(
                  AppStrings.loginWithClinic,
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
                        controller: _passwordController,
                        labelText: AppStrings.password,
                        prefixIcon: Icons.lock,
                        isPassword: true,
                        hintText: AppStrings.enterYourPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.requiredField;
                          } else if (value.length < 8) {
                            return AppStrings.shortPassword;
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: AppButtonPrimary(
                        textButton: AppStrings.login, onPressed: () {}),
                  ),
                ),
                const SizedBox(height: 4),
                AppAuthNavigation(
                  text: AppStrings.alreadyNotHaveAnAccount,
                  actionText: AppStrings.register,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
