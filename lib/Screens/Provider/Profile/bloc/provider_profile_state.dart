part of 'provider_profile_bloc.dart';

@immutable
sealed class ProviderProfileState {}

final class ProviderProfileInitial extends ProviderProfileState {}

class SuccessState extends ProviderProfileState {}

class ErrorState extends ProviderProfileState {}

