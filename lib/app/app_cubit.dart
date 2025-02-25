import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/app/app_state.dart';
import 'package:todo_list_app/domains/authentication_repository/authentication_repository.dart';

class AppCubit extends Cubit<AppState> {
  final AuthenticationRepository authenticationRepository;

  AppCubit(this.authenticationRepository) : super(AppState()) {
    authenticationRepository.status.listen((status) {
      emit(state.copyWith(status: status));
    });
  }
}
