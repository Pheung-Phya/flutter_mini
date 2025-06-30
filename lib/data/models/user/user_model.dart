import 'package:equatable/equatable.dart';
import '../../../domain/entities/user_entity.dart';

class UserModel extends UserEntity with EquatableMixin {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    if (user == null) {
      throw Exception("User data is missing from response");
    }

    return UserModel(
      id: user['id'] ?? 0,
      name: user['name'] ?? '',
      email: user['email'] ?? '',
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = {'name': name, 'email': email};
    if (token != null) {
      data['token'] = token.toString();
    }
    return data;
  }

  UserEntity toEntity() {
    return UserEntity(id: id, name: name, email: email, token: token);
  }

  @override
  List<Object?> get props => [id, name, email, token];
}
