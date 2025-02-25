import 'package:equatable/equatable.dart';
import 'package:todo_list_app/ui/utils.enums/authentication_status.dart';

class AppState extends Equatable {
  final AuthenticationStatus status;
  const AppState({this.status = AuthenticationStatus.unknown});

  AppState copyWith({
    AuthenticationStatus? status,
  }) {
    return AppState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        status,
      ];
}
