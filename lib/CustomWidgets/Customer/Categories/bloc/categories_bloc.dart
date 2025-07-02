import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glowup/Repositories/models/services.dart';
part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final Map<int, List<String>> subCategoryMap = {
    0: ['Blow Dry', 'Haircut', 'Coloring'],
    1: ['Full Makeup', 'Eyes Only', 'Lashes'],
    2: ['Manicure', 'Pedicure', 'Gel Nails'],
    3: ['Threading', 'Waxing'],
  };

  final Map<int, List<String>> contentMap = {
    0: ['Blow Dry Details', 'Haircut Details', 'Coloring Details'],
    1: ['Makeup Package', 'Eye Styling', 'Lash Add-ons'],
    2: ['Spa Manicure', 'Deluxe Pedicure', 'Gel Polish'],
    3: ['Facial Threading', 'Body Wax'],
  };

  CategoriesBloc()
      : super(CategoriesState(
          selectedIndex: 0,
          selectedSubIndex: 0,
          subCategories: ['Blow Dry', 'Haircut', 'Coloring'],
          content: ['Blow Dry Details', 'Haircut Details', 'Coloring Details'],// put the content cards here somehow
          services: [],
        )) {
    on<CategoriesSelectEvent>((event, emit) {
      emit(CategoriesState(
        selectedIndex: event.index,
        selectedSubIndex: 0,
        subCategories: subCategoryMap[event.index] ?? [],
        content: contentMap[event.index] ?? [],
        services: [
          Services(
            id: 1,
            name: 'Hair Curling',
            description: 'Defined curls',
            durationMinutes: 30,
            price: 230,
            providerId: '123',
          ),
        ],
      ));
    });

    on<CategoriesSubSelectEvent>((event, emit) {
      emit(state.copyWith(selectedSubIndex: event.subIndex));
    });
  }
}



