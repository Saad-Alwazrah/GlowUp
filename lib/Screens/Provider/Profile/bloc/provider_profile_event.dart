part of 'provider_profile_bloc.dart';

@immutable
sealed class ProviderProfileEvent {}

class SubmitChange extends ProviderProfileEvent {}

final class LanguageSwitchToggleEvent extends ProviderProfileEvent {}

final class ThemeSwitchToggleEvent extends ProviderProfileEvent {}

final class UpdateProviderAvatarEvent extends ProviderProfileEvent {}

final class UpdateUIEvent extends ProviderProfileEvent {}

final class LogOutProvider extends ProviderProfileEvent {}
