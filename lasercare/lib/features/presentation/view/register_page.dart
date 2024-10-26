import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/style/app_colors.dart';
import '../../../core/ultils/app_formatter_input.dart';
import '../../../core/ultils/app_images.dart';
import '../../../core/ultils/app_routes.dart';
import '../../../core/ultils/app_strings.dart';
import '../providers/register_provider.dart';
import '../widgets/app_auth_navigation.dart';
import '../widgets/app_button_primary.dart';
import '../widgets/app_circular_progress_primary.dart';
import '../widgets/app_text_form.dart';

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

  bool checkValue = false;
  final cnpjFormatter = AppFormatterInput.cnpjFormatter;

  void _submitForm() {
    if (!_keyForm.currentState!.validate()) return;

    final provider = Provider.of<RegisterProvider>(context, listen: false);
    provider.registerUser(
      name: _nameController.text,
      email: _emailController.text,
      cnpj: _cnpjController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvider>(builder: (context, provider, _) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (provider.isSuccess) {
          Navigator.of(context).pushNamed(AppRoutes.loginPage);
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
              padding: const EdgeInsets.only(
                  left: 32, right: 32, top: 38, bottom: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.curativeLogo, width: 68, height: 68),
                  const SizedBox(height: 24),
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
                            } else if (value != _passwordController.text) {
                              return AppStrings.passwordsDoNotMatch;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 4),
                        FormField(
                          builder: (state) => Column(
                            children: [
                              Row(
                                children: [
                                  Transform.scale(
                                    scale: 0.8,
                                    child: Checkbox(
                                        checkColor: Colors.white,
                                        activeColor: AppColors.primaryColor,
                                        value: checkValue,
                                        onChanged: (value) => setState(() {
                                              checkValue = value!;
                                              state.didChange(value);
                                            })),
                                  ),
                                  const Text(AppStrings.aceptThe,
                                      style: TextStyle(fontSize: 12)),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(AppRoutes.termsOfUsePage);
                                    },
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
                              (state.hasError)
                                  ? Text(
                                      state.errorText ?? '',
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).colorScheme.error,
                                        fontSize: 12,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                          validator: (value) {
                            if (!checkValue) {
                              return 'Para continuar, aceite os termos de uso';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  provider.isLoading
                      ? const AppCircularProgressPrimary()
                      : Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: SizedBox(
                              width: double.infinity,
                              child: AppButtonPrimary(
                                textButton: AppStrings.register,
                                onPressed: () {
                                  _submitForm();
                                },
                              )),
                        ),
                  const SizedBox(height: 4),
                  AppAuthNavigation(
                      text: AppStrings.alreadyHaveAnAccount,
                      actionText: AppStrings.login,
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.loginPage);
                      }),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
