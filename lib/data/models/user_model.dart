class UserModel {
  final int id;
  final String name;
  final String email;
  final String? token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = {'id': id, 'name': name, 'email': email};

    if (token != null) {
      data['token'] = token.toString();
    }

    return data;
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, token: $token)';
  }
}
