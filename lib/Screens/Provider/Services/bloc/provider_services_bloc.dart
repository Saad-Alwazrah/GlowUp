import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:glowup/Repositories/api/supabase_connect.dart';
import 'package:meta/meta.dart';

part 'provider_services_event.dart';
part 'provider_services_state.dart';

class ProviderServicesBloc
    extends Bloc<ProviderServicesEvent, ProviderServicesState> {
  final supabase = GetIt.I.get<SupabaseConnect>();
  ProviderServicesBloc() : super(ProviderServicesInitial()) {
    on<ProviderServicesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
