import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:glowup/Repositories/api/supabase_connect.dart';
import 'package:image_picker/image_picker.dart';
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
    on<UpdateUserAvatar>((event, emit) async {
      XFile? pickedAvatar = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (pickedAvatar != null) {
        final updateStatus = await supabase.uploadUserAvatar(
          localFilePath: pickedAvatar.path,
          userId: supabase.userProfile!.id,
        );
        if (updateStatus) {
          emit(UserAvatarUpdated());
        } else {
          emit(UpdateAvatarError("Failed to update avatar"));
        }
      }
    });
    on<LoadProfileAvatar>((event, emit) async {
      final avatarUrl = supabase.userProfile?.avatarUrl;
      if (avatarUrl != null) {
        emit(UserAvatarLoaded());
      } else {
        emit(UpdateAvatarError("Failed to load avatar"));
      }
    });
  }
}
