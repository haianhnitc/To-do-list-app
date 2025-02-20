import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String title;
  const LoginState(
    this.title,
  );

  @override
  List<Object> get props => [
        title,
      ];
}
