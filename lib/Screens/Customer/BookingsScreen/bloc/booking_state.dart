class BookingState {
  final int selectedIndex; // 0 = Pending, 1 = Status, etc.

  BookingState({required this.selectedIndex});

  BookingState copyWith({int? selectedIndex}) {
    return BookingState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
