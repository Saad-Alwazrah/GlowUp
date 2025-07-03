part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class UserLoggedOut extends ProfileState {}

final class LogOutError extends ProfileState {
  final String message;

  LogOutError(this.message);
}
