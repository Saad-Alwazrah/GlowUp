import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:glowup/Screens/Customer/NavBar/nav_bar_screen.dart';
import 'package:glowup/Screens/onboarding/onboarding_screen.dart';
import 'package:glowup/Screens/splash/splash.dart';
import 'package:glowup/Styles/theme.dart';
import 'package:glowup/Utilities/setup.dart';
import 'package:glowup/CustomWidgets/Customer/Categories/bloc/categories_bloc.dart'; // 👈 make sure this is imported

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(const MyApp());
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
        theme: lightTheme,
        darkTheme: darkTheme,
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/onboarding': (context) => const OnboardingScreen(),
          '/navbar': (context) => BlocProvider(
            create: (_) => CategoriesBloc(),
            child: const NavBarScreen(),
          ),
        },
      ),
    );
  }
}

