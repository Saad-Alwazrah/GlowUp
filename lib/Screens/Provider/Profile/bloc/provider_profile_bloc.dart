import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'provider_profile_event.dart';
part 'provider_profile_state.dart';

class ProviderProfileBloc
    extends Bloc<ProviderProfileEvent, ProviderProfileState> {
  final usernameKey = GlobalKey<FormState>();
  final phoneNumberKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  // final username = GetIt.I.get<SupabaseConnect>().userProfile.username;

  ProviderProfileBloc() : super(ProviderProfileInitial()) {
    on<ProviderProfileEvent>((event, emit) {});
  }

  validationMethod(GlobalKey<FormState> validationKey) {
    if (validationKey.currentState!.validate()) {
      emit(SuccessState());
    } else {
      emit(ErrorState());
    }
  }

  String? userNameValidation({String? text}) {
    if (text == null || text.isEmpty) {
      return "This field is required";
    } else if (text.length < 3) {
      return "the name should atleast be 4 charectars long";
    } else {
      return null;
    }
  }

  // The regular Expression for the email  (true = email is valid ---- false = email is invalid)
  bool isEmailValid(String? email) {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(email!);
  }

  // Need to check if the Email already exist
  String? emailValidation({String? text}) {
    if (text == null || text.isEmpty) {
      return "This field is required";
    } else if (!isEmailValid(text)) {
      return "The email is invalid";
    } else {
      return null;
    }
  }


  // Need to check if phone alraedy exist in Supabase
  String? phoneValidation({String? text}) {
    if (text == null || text.isEmpty) {
      return "This field is required";
    } else if (!text.startsWith('05')) {
      return "The number must start with 05";
    } else if (text.length != 10) {
      return "the number you enterd is Inavlid";
    } else {
      return null;
    }
  }
}
