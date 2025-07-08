import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:glowup/Repositories/api/supabase_connect.dart';
import 'package:glowup/Repositories/models/provider.dart';
import 'package:meta/meta.dart';

part 'employee_details_event.dart';
part 'employee_details_state.dart';

class EmployeeDetailsBloc
    extends Bloc<EmployeeDetailsEvent, EmployeeDetailsState> {
  
  Provider provider = GetIt.I.get<SupabaseConnect>().theProvider!;

  EmployeeDetailsBloc() : super(EmployeeDetailsInitial()) {
    on<EmployeeDetailsEvent>((event, emit) {});
  }
}
