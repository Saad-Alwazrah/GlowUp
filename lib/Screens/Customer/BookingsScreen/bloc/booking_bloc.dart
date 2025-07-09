import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:glowup/Repositories/api/supabase_connect.dart';
import 'package:glowup/Repositories/models/appointment.dart';
import 'package:meta/meta.dart';
part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final supabase = GetIt.I.get<SupabaseConnect>();
  int selectedIndex = 0;

  BookingBloc() : super(BookingInitial()) {
    on<StatusToggleEvent>((event, emit) {
      selectedIndex = event.index;
      emit(StatusToggleChanged());
    });
    on<UpdateUIEvent>((event, emit) {
      emit(UIUpdated());
    });
  }
}
