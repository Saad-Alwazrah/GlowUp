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
    final Color selectedColor = AppColors.white;
    final Color unselectedColor = AppColors.softBrown;
    final Color selectedTextColor = AppColors.darkText;
    final Color unselectedTextColor = AppColors.white;

    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeBloc(),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            final bloc = context.read<HomeBloc>();
            List<String> mapKeys = bloc.categoriesAndSub.keys.toList();

            final mainIcons = [
              'assets/svgs/hair_comb 1.svg',
              'assets/svgs/Make_up.svg',
              'assets/svgs/Nail_polish.svg',
              'assets/svgs/Make_up.svg',
              'assets/svgs/more.svg',
            ];

            return SizedBox(
              height: context.getScreenHeight(size: 1),
              width: context.getScreenWidth(size: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  const Padding(
                    padding: EdgeInsets.only(left: 50),
                    child: Text("Hello, Sara", style: AppFonts.black32),
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
                        itemCount: mapKeys.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Categories(
                              label: mapKeys[index],
                              svgIconPath: mainIcons[index],
                              isSelected: bloc.selectedIndex == index,
                              onTap: () {
                                bloc.selectedCategory = mapKeys[index];
                                bloc.add(CategorySelectEvent(index));
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// 🔸 SUBCATEGORIES
                  Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: SizedBox(
                      height: 40,
                      width: context.getScreenWidth(size: 1),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: bloc
                            .categoriesAndSub[bloc.selectedCategory]!
                            .length,
                        itemBuilder: (context, index) {
                          final isSelected = bloc.selectedSubIndex == index;
                          final subCategories =
                              bloc.categoriesAndSub[bloc.selectedCategory]!;
                          return Padding(
                            padding: EdgeInsets.all(4.w),
                            child: GestureDetector(
                              onTap: () {
                                bloc.selectedSubCategory = subCategories[index];

                                bloc.add(SubCategorySelectEvent(index));
                              },
                              child: Chip(
                                label: Text(
                                  bloc.categoriesAndSub[bloc
                                      .selectedCategory]![index],
                                  style: TextStyle(
                                    color: isSelected
                                        ? selectedTextColor
                                        : unselectedTextColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                backgroundColor: isSelected
                                    ? selectedColor
                                    : unselectedColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  const SizedBox(height: 24),

                  /// 🔸 SERVICES LIST
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      itemCount: bloc.supabaseConnect.services
                          .where(
                            (service) =>
                                service.subCategory == bloc.selectedSubCategory,
                          )
                          .length,
                      itemBuilder: (context, index) {
                        final filteredServices = bloc.supabaseConnect.services
                            .where(
                              (service) =>
                                  service.subCategory ==
                                  bloc.selectedSubCategory,
                            )
                            .toList();
                        final service = filteredServices[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ServiceCard(service: service),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
