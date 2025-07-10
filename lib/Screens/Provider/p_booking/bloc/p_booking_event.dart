part of 'p_booking_bloc.dart';

abstract class PBookingEvent {}

final class PStatusToggleChanged extends PBookingEvent {
  final int index;
  PStatusToggleChanged(this.index);
}

final class SubscribeToStreamEvent extends PBookingEvent {}
