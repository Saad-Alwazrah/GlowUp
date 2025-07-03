import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:glowup/Repositories/api/supabase_connect.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final supabase = GetIt.I.get<SupabaseConnect>();
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<LogOutUser>((event, emit) async {
      final signOutStatus = await supabase.signOut();
      if (signOutStatus) {
        emit(UserLoggedOut());
      } else {
        emit(LogOutError("Failed to log out"));
      }
    });
  }
}
