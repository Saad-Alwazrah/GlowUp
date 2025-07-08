abstract class PBookingEvent {}

class PStatusToggleChanged extends PBookingEvent {
  final int index;
  PStatusToggleChanged(this.index);
}

