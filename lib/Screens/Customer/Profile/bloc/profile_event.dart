part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class LogOutUser extends ProfileEvent {}

final class UpdateUserAvatar extends ProfileEvent {
  UpdateUserAvatar();
}

final class LoadProfileAvatar extends ProfileEvent {}

final class ThemeModeChange extends ProfileEvent {}
