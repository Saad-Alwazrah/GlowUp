import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glowup/CustomWidgets/Customer/Categories/Categories_widget.dart';
import 'package:glowup/CustomWidgets/Customer/Categories/bloc/categories_bloc.dart';
import 'package:glowup/CustomWidgets/Customer/search_bar.dart';
import 'package:glowup/CustomWidgets/Customer/service_card.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Styles/app_font.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color selectedColor = AppColors.white;
    final Color unselectedColor = AppColors.softBrown;
    final Color selectedTextColor = AppColors.darkText;
    final Color unselectedTextColor = AppColors.white;

    return Scaffold(
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          final serviceList = state.services;
          final mainLabels = ['Hair', 'Makeup', 'Nails', 'More'];
          final mainIcons = [
            'lib/assets/svgs/hair_comb 1.svg',
            'lib/assets/svgs/Make_up.svg',
            'lib/assets/svgs/Nail_polish.svg',
            'lib/assets/svgs/more.svg',
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
                child: Text("Are you ready for a Glow Up", style: AppFonts.light16),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  SizedBox(width: 32,),
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
                        isSelected: state.selectedIndex == index,
                        onTap: () {
                          context.read<CategoriesBloc>().add(CategoriesSelectEvent(index));
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
                  children: List.generate(state.subCategories.length, (index) {
                    final isSelected = state.selectedSubIndex == index;
                    return GestureDetector(
                      onTap: () {
                        context.read<CategoriesBloc>().add(CategoriesSubSelectEvent(index));
                      },
                      child: Chip(
                        label: Text(
                          state.subCategories[index],
                          style: TextStyle(
                            color: isSelected ? selectedTextColor : unselectedTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        backgroundColor: isSelected ? selectedColor : unselectedColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 24),

              /// 🔸 CONTENT BASED ON SELECTION
              Padding(
                padding: const EdgeInsets.only(left: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state.selectedSubIndex < state.content.length)
                      Text(state.content[state.selectedSubIndex]),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// 🔸 SERVICES LIST
              // Expanded(
              //   child: ListView.builder(
              //     padding: const EdgeInsets.symmetric(horizontal: 32),
              //     itemCount: serviceList.length,
              //     itemBuilder: (context, index) {
              //       final service = serviceList[index];
              //       return Padding(
              //         padding: const EdgeInsets.only(bottom: 16),
              //         child: ServiceCard(
              //           service: service,
              //           salonName: service.provider?.name ?? 'Unknown',
              //           rating: 4.8,
              //           location: 'Al Malqa, Riyadh · 3.2 km',
              //           imageUrl: 'https://via.placeholder.com/300',
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          );
        },
      ),
    );
  }
}
