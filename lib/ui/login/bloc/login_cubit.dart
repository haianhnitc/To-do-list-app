import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/domains/authentication_repository/authentication_repository.dart';
import 'package:todo_list_app/ui/login/bloc/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository authenticationRepository;

  LoginCubit(
    this.authenticationRepository,
  ) : super(const LoginState());

  Future<void> login(String email, String password) async {
    try {
      await authenticationRepository.logInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e);
    }
  }
}
