import 'package:flutter/material.dart';
import 'package:lasercare/core/ultils/app_routes.dart';
import 'package:lasercare/features/presentation/widgets/app_circular_progress_primary.dart';
import 'package:provider/provider.dart';

import '../../../core/ultils/app_images.dart';
import '../providers/login_provider.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submitLogin() {
    if (!_keyForm.currentState!.validate()) return;

    final provider = Provider.of<LoginProvider>(context, listen: false);

    provider.loginUser(
      _emailController.text,
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, provider, _) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (provider.isSuccess) {
          Navigator.of(context).pushNamed(AppRoutes.homePage);
        } else if (provider.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(provider.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }
      });

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
                  provider.isLoading
                      ? const AppCircularProgressPrimary()
                      : Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: AppButtonPrimary(
                                textButton: AppStrings.login,
                                onPressed: () {
                                  _submitLogin();
                                }),
                          ),
                        ),
                  const SizedBox(height: 4),
                  AppAuthNavigation(
                    text: AppStrings.alreadyNotHaveAnAccount,
                    actionText: AppStrings.register,
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.registerPage);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
