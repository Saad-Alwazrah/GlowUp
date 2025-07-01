part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class SuccessState extends LoginState{}

class ErrorState extends LoginState{}

