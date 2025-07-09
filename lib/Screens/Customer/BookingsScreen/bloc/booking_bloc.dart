import 'package:flutter_bloc/flutter_bloc.dart';
import 'booking_event.dart';
import 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(const BookingState(selectedIndex: 0)) {
    on<StatusToggleChanged>((event, emit) {
      emit(state.copyWith(selectedIndex: event.index));
    });
  }
}

