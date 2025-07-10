part of 'p_booking_bloc.dart';

@immutable
sealed class PBookingState {}

final class PBookingInitial extends PBookingState {}

final class StatusToggleChanged extends PBookingState {}

final class UpdateFromStream extends PBookingState {}

final class ErrorUpdatingStream extends PBookingState {
  final String errorMessage;

  ErrorUpdatingStream(this.errorMessage);
}
