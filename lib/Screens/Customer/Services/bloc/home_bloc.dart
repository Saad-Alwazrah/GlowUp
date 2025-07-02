import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:glowup/Repositories/api/supabase_connect.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int selectedIndex = 0;
  int selectedSubIndex = 0;
  SupabaseConnect supabaseConnect = GetIt.I<SupabaseConnect>();
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CategorySelectEvent>((event, emit) {
      selectedIndex = event.index;
      emit(CategorySelectedState());
    });
    on<SubCategorySelectEvent>((event, emit) {
      selectedSubIndex = event.subIndex;
      emit(CategorySelectedState());
    });
  }
}
