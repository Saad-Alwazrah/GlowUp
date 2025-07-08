class BookingState {
  final int selectedIndex;

  const BookingState({required this.selectedIndex});

  BookingState copyWith({int? selectedIndex}) {
    return BookingState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
