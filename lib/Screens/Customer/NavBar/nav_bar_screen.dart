import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glowup/Screens/Customer/BookingsScreen/Bookings_screen.dart';

import 'package:glowup/Screens/Customer/Providers/providers_screen.dart';
import 'package:glowup/Screens/Customer/NavBar/bloc/nav_bar_bloc.dart';
import 'package:glowup/Screens/Customer/Profile/profile_screen.dart';
import 'package:glowup/Screens/Customer/Services/home_screen.dart';

class NavBarScreen extends StatelessWidget {
  const NavBarScreen({super.key});

  final List<String> svgPaths = const [
    'assets/svgs/home.svg',
    'assets/svgs/salons.svg',
    'assets/svgs/booking.svg',
    'assets/svgs/me.svg',
  ];

  final List<String> labels = const ["Home", "Providers", "Bookings", "Me"];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavBarBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<NavBarBloc, NavBarState>(
          builder: (context, state) {
            return Stack(
              children: [
                IndexedStack(
                  index: state.selectedIndex,
                  children: const [
                    HomeScreen(),
                    ProvidersScreen(),
                    BookingsScreen(),
                    ProfileScreen(),
                  ],
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 390,
                    height: 70,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2E3C6),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(svgPaths.length, (index) {
                        final isActive = state.selectedIndex == index;

                        return GestureDetector(
                          onTap: () {
                            context.read<NavBarBloc>().add(
                              ChangeTabEvent(index),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                svgPaths[index],
                                colorFilter: ColorFilter.mode(
                                  isActive
                                      ? const Color(0xFF8A766D)
                                      : const Color(0xFFCBB9A8),
                                  BlendMode.srcIn,
                                ),
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                labels[index],
                                style: TextStyle(
                                  color: isActive
                                      ? const Color(0xFF8A766D)
                                      : const Color(0xFFCBB9A8),
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
  }
}
