part of 'booking_bloc.dart';

abstract class BookingEvent {}

final class UpdateUIEvent extends BookingEvent {}

final class StatusToggleEvent extends BookingEvent {
  final int index;
  StatusToggleEvent(this.index);
}

final class SubscribeToStreamEvent extends BookingEvent {}
