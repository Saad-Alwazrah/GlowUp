import 'package:flutter_bloc/flutter_bloc.dart';
import 'p_booking_event.dart';
import 'p_booking_state.dart';

class PBookingBloc extends Bloc<PBookingEvent, PBookingState> {
  PBookingBloc() : super(const PBookingState(selectedIndex: 0)) {
    on<PStatusToggleChanged>((event, emit) {
      emit(state.copyWith(selectedIndex: event.index));
    });
  }
}

