import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/Customer/Categories/Categories_widget.dart';
import 'package:glowup/CustomWidgets/Customer/Services/service_card.dart';
import 'package:glowup/CustomWidgets/Shared/search_bar.dart';
import 'package:glowup/Screens/Customer/Services/bloc/home_bloc.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Styles/app_font.dart';
import 'package:glowup/Utilities/extensions/screen_size.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeBloc(),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            final bloc = context.read<HomeBloc>();
            final categories = bloc.categories;

            final mainIcons = [
              'assets/svgs/hair_comb 1.svg',
              'assets/svgs/Make_up.svg',
              'assets/svgs/Nail_polish.svg',
              'assets/svgs/Make_up.svg',
              'assets/svgs/Make_up.svg',
            ];

            return SizedBox(
              height: context.getScreenHeight(size: 1.h),
              width: context.getScreenWidth(size: 1.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Text(
                        "Hello, ${bloc.supabaseConnect.userProfile?.username ?? ""}",
                        style: AppFonts.black32,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 50, top: 10),
                      child: Text(
                        "Are you ready for a Glow Up",
                        style: AppFonts.light16,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        SizedBox(width: 32),
                        CustomSearchBar(
                          controller: TextEditingController(),
                          hintText: "Search salons",
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    /// 🔹 MAIN CATEGORIES
                    Padding(
                      padding: EdgeInsets.only(left: 32.w),
                      child: SizedBox(
                        width: context.getScreenWidth(size: 1),
                        height: 90.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Categories(
                                label: categories[index],
                                svgIconPath: mainIcons[index],
                                isSelected: bloc.selectedIndex == index,
                                onTap: () {
                                  bloc.selectedCategory = categories[index];
                                  bloc.add(CategorySelectEvent(index));
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// 🔸 SERVICES LIST
                    SizedBox(
                      height: 300.h,
                      width: context.getScreenWidth(size: 1.w),

                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        itemCount: bloc.supabaseConnect.services.where((
                          service,
                        ) {
                          return service.category == bloc.selectedCategory;
                        }).length,
                        itemBuilder: (context, index) {
                          final filteredServices = bloc.supabaseConnect.services
                              .where((service) {
                                return service.category ==
                                    bloc.selectedCategory;
                              })
                              .toList();
                          final service = filteredServices[index];
                          return SizedBox(
                            width: 207.w,
                            height: 300.h,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: ServiceCard(service: service),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Most Rated Salons Services",
                        style: AppFonts.regular22.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 300.h,
                      width: context.getScreenWidth(size: 1.w),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          var filteredServices = List.from(
                            bloc.supabaseConnect.services,
                          );
                          filteredServices.sort((a, b) {
                            if (a.provider!.ratingCount! >=
                                b.provider!.ratingCount!) {
                              return 1; // b comes before a
                            } else {
                              return -1; // a comes before b
                            }
                          });
                          filteredServices = filteredServices.sublist(0, 4);

                          final service = filteredServices[index];
                          return SizedBox(
                            width: 207.w,
                            height: 300.h,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: ServiceCard(service: service),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 100.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
