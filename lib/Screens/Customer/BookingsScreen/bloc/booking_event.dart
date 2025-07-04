abstract class BookingEvent {}

class ChangeBookingTab extends BookingEvent {
  final int index;
  ChangeBookingTab(this.index);
}
