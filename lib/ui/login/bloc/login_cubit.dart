import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/ui/login/bloc/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState(""));

  void login(String email, String password) {
    // Call API login
    // If success, emit state with title "Login success"
    // If fail, emit state with title "Login fail"
    print("Login with email: $email, password: $password");
  }
}
