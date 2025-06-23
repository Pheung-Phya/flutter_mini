class UserEntity {
  final int id;
  final String name;
  final String email;
  final String? token;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.token,
  });
}
