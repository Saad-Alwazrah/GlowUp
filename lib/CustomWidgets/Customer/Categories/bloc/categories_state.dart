part of 'categories_bloc.dart';

class CategoriesState {
  final int selectedIndex;
  final int selectedSubIndex;
  final List<String> subCategories;
  final List<String> content;
   final List<Services> services;

  const CategoriesState({
    required this.selectedIndex,
    required this.selectedSubIndex,
    required this.subCategories,
    required this.content,
      this.services = const [],
  });

  CategoriesState copyWith({
    int? selectedIndex,
    int? selectedSubIndex,
    List<String>? subCategories,
    List<String>? content,
       List<Services>? services,
  }) {
    return CategoriesState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      selectedSubIndex: selectedSubIndex ?? this.selectedSubIndex,
      subCategories: subCategories ?? this.subCategories,
      content: content ?? this.content,
            services: services ?? this.services,

    );
  }
}


