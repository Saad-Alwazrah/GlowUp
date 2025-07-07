import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glowup/Screens/Provider/Apppointments/provider_appointments_screen.dart';
import 'package:glowup/Screens/Provider/NavBar/bloc/provider_nav_bar_bloc.dart';

import 'package:glowup/Screens/Provider/Profile/provider_profile_screen.dart';
import 'package:glowup/Screens/Provider/Services/provider_services_screen.dart';


class ProviderNavBarScreen extends StatelessWidget {
  const ProviderNavBarScreen({super.key});

  final List<String> svgPaths = const [
    'assets/svgs/home.svg',
    'assets/svgs/booking.svg',
    'assets/svgs/me.svg',
  ];

  final List<String> labels = const ["Services", "Bookings", "Me"];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProviderNavBarBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: BlocBuilder<ProviderNavBarBloc, ProviderNavBarState>(
          builder: (context, state) {
            return Stack(
              children: [
                IndexedStack(
                  index: state.selectedIndex,
                  children:  [
                    ProviderServicesScreen(),
                    ProviderAppointmentsScreen(),
                    ProviderProfileScreen(),
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
                            context.read<ProviderNavBarBloc>().add(
                                  ChangeProviderTabEvent(index),
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

