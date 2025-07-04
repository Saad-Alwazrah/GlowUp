import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glowup/Screens/Customer/BookingsScreen/bloc/booking_bloc.dart';
import 'package:glowup/Screens/Customer/BookingsScreen/bookings_screen.dart';
import 'package:glowup/Screens/Customer/Profile/bloc/profile_bloc.dart';
import 'package:glowup/Screens/Customer/Profile/bloc/profile_event.dart';
import 'package:glowup/Screens/Customer/Providers/providers_screen.dart';
import 'package:glowup/Screens/Customer/NavBar/bloc/nav_bar_bloc.dart';
import 'package:glowup/Screens/Customer/Profile/profile_screen.dart';
import 'package:glowup/Screens/Customer/Services/home_screen.dart';
import 'package:glowup/Styles/Theme/bloc/theme_bloc.dart';
import 'package:glowup/Styles/Theme/bloc/theme_state.dart';

class NavBarScreen extends StatelessWidget {
   NavBarScreen({super.key});

  final List<String> svgPaths = const [
    'assets/svgs/home.svg',
    'assets/svgs/salons.svg',
    'assets/svgs/booking.svg',
    'assets/svgs/me.svg',
  ];


final List<String> labels = [
  "home".tr(),
  "providers".tr(),
  "bookings".tr(),
  "me".tr(),
];


 @override
Widget build(BuildContext context) {
  return BlocBuilder<ThemeBloc, ThemeState>(
    builder: (context, themeState) {
      final isDark = themeState.themeMode == ThemeMode.dark;

      return BlocProvider(
        create: (_) => NavBarBloc(),
        child: Scaffold(
          backgroundColor: isDark ? Colors.black : Colors.white,
          body: BlocBuilder<NavBarBloc, NavBarState>(
            builder: (context, state) {
              return Stack(
                children: [
                  IndexedStack(
                    index: state.selectedIndex,
                    children: [
                      const HomeScreen(),
                      const ProvidersScreen(),
                      BlocProvider(
                        create: (_) => BookingBloc(),
                        child: const BookingsScreen(),
                      ),
                      BlocProvider(
                        create: (_) => ProfileBloc()..add(LoadProfile()),
                        child: const ProfileScreen(),
                      ),
                    ],
                  ),

                  // BOTTOM NAVIGATION BAR
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 390.w,
                      height: 70.h,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF2E2E2E) : const Color(0xFFF2E3C6),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(svgPaths.length, (index) {
                          final isActive = state.selectedIndex == index;

                          final activeColor = isDark ? Colors.white : const Color(0xFF8A766D);
                          final inactiveColor = isDark ? Colors.grey : const Color(0xFFCBB9A8);

                          return GestureDetector(
                            onTap: () {
                              context.read<NavBarBloc>().add(ChangeTabEvent(index));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  svgPaths[index],
                                  colorFilter: ColorFilter.mode(
                                    isActive ? activeColor : inactiveColor,
                                    BlendMode.srcIn,
                                  ),
                                  width: 24.w,
                                  height: 24.h,
                                ),
                               SizedBox(height: 4.h),
                                Text(
                                  labels[index],
                                  style: TextStyle(
                                    color: isActive ? activeColor : inactiveColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    },
  );
}
}
