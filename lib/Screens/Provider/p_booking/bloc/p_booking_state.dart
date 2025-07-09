class PBookingState {
  final int selectedIndex;

  const PBookingState({required this.selectedIndex});

  PBookingState copyWith({int? selectedIndex}) {
    return PBookingState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}

