part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class UserLoggedOut extends ProfileState {}

final class LogOutError extends ProfileState {
  final String message;

  LogOutError(this.message);
}

final class UserAvatarUpdated extends ProfileState {}

final class UserAvatarLoaded extends ProfileState {}

final class UpdateAvatarError extends ProfileState {
  final String message;

  UpdateAvatarError(this.message);
}

final class ThemeModeChanged extends ProfileState {}
