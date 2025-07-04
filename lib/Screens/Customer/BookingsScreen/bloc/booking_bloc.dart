import 'package:bloc/bloc.dart';
import 'package:glowup/Screens/Customer/BookingsScreen/bloc/booking_event.dart';
import 'package:glowup/Screens/Customer/BookingsScreen/bloc/booking_state.dart';


class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingState(selectedIndex: 0)) {
    on<ChangeBookingTab>((event, emit) {
      emit(state.copyWith(selectedIndex: event.index));
    });
  }
}



