import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/domains/authentication_repository/authentication_repository.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthenticationRepository authenticationRepository;

  RegisterCubit(this.authenticationRepository) : super(RegisterState());

  Future<void> register(String email, String password) async {
    try {
      authenticationRepository.registerWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e);
    }
  }
}
