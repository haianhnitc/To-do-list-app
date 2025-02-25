import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String? email;
  final String? name;
  final String? photo;

  const UserEntity({
    required this.id,
    this.email,
    this.name,
    this.photo,
  });

  static const empty = UserEntity(id: '');
  bool get isEmpty => this == UserEntity.empty;
  bool get isNotEmpty => this != UserEntity.empty;

  @override
  // TODO: implement props
  List<Object?> get props => [id, email, name, photo];
}
