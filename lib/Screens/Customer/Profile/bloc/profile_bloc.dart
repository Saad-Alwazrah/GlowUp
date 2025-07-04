import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glowup/Repositories/models/profile.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) {
      
      final dummy = Profile(
        id: '1',
        fullName: 'Sara abc',
        phone: '0501234567',
        username: 'sARATHEVDS',
        role: 'customer',
        latitude: 24.7136,
        longitude: 46.6753,
        mapsUrl: 'https://maps.google.com',
      );
      emit(ProfileLoaded(dummy));
    });
  }
}

