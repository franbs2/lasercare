import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'core/ultils/app_routes.dart';
import 'features/presentation/providers/register_provider.dart';
import 'features/presentation/view/login_page.dart';
import 'features/presentation/view/register_page.dart';
import 'features/presentation/view/terms_of_use_page.dart';
import 'firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ],
        child: MaterialApp(
            home: const RegisterPage(),
            theme: ThemeData(
              textTheme: GoogleFonts.soraTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            routes: {
              AppRoutes.loginPage: (context) => const LoginPage(),
              AppRoutes.termsOfUsePage: (context) => const TermsOfUsePage(),
            }));
  }
}
