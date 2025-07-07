import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'employee_details_event.dart';
part 'employee_details_state.dart';

class EmployeeDetailsBloc extends Bloc<EmployeeDetailsEvent, EmployeeDetailsState> {
  EmployeeDetailsBloc() : super(EmployeeDetailsInitial()) {
    on<EmployeeDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
