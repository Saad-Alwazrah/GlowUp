abstract class BookingEvent {}

class StatusToggleChanged extends BookingEvent {
  final int index;
  StatusToggleChanged(this.index);
}
