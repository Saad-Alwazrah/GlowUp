import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glowup/CustomWidgets/Customer/Categories/Categories_widget.dart';
import 'package:glowup/CustomWidgets/Customer/search_bar.dart';
import 'package:glowup/Screens/Customer/Services/bloc/home_bloc.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Styles/app_font.dart';

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
            final mainLabels = ['Hair', 'Makeup', 'Nails', 'More'];
            final mainIcons = [
              'assets/svgs/hair_comb 1.svg',
              'assets/svgs/Make_up.svg',
              'assets/svgs/Nail_polish.svg',
              'assets/svgs/more.svg',
            ];

            return Column(
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
                  padding: const EdgeInsets.only(left: 32),
                  child: Row(
                    children: List.generate(mainLabels.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Categories(
                          label: mainLabels[index],
                          svgIconPath: mainIcons[index],
                          isSelected: bloc.selectedIndex == index,
                          onTap: () {
                            bloc.add(CategorySelectEvent(index));
                          },
                        ),
                      );
                    }),
                  ),
                ),

                const SizedBox(height: 16),

                /// 🔸 SUBCATEGORIES
                Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(
                      bloc.supabaseConnect.services.length,
                      (index) {
                        final isSelected = bloc.selectedSubIndex == index;
                        return GestureDetector(
                          onTap: () {
                            bloc.add(SubCategorySelectEvent(index));
                          },
                          child: Chip(
                            label: Text(
                              bloc.supabaseConnect.services[index].subCategory,
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
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            );
          },
        ),
      ),
    );
  }
}
