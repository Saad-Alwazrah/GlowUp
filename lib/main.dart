import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/Screens/Customer/NavBar/nav_bar_screen.dart';
import 'package:glowup/Screens/Shared/Login/login_screen.dart';
import 'package:glowup/Screens/Shared/Onboarding/onboarding_screen.dart';
import 'package:glowup/Screens/Shared/splash/splash.dart';
import 'package:glowup/Screens/Customer/SignUp/sign_up_screen.dart';
import 'package:glowup/Styles/theme.dart';
import 'package:glowup/Utilities/setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure that the setup is completed before running the app
  // This is where we initialize services, load environment variables, etc.
  await setup();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale("en"), Locale("ar")],
      path: "assets/translations",
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(402, 952),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: lightTheme,
        darkTheme: darkTheme,
        initialRoute: '/splashscreen',
        routes: {
          '/splashscreen': (context) => const SplashScreen(),
          '/onboarding': (context) => const OnboardingScreen(),
          '/signup': (context) => const SignUpScreen(),
          '/login': (context) => const LoginScreen(),
          '/navbar': (context) => const NavBarScreen(),
        },
      ),
    );
  }
}
