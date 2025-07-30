import 'package:flutter_mini/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required int id,
    required String name,
    required String email,
    String? token,
  }) : super(id: id, name: name, email: email, token: token);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] ?? json;

    return UserModel(
      id: user['id'],
      name: user['name'],
      email: user['email'],
      token: json['token'], // assuming token is outside the user object
    );
  }

  factory UserModel.empty() {
    return const UserModel(id: 0, name: '', email: '', token: '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'token': token};
  }
}
