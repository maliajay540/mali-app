class UserEntity {
  final int id;
  final String phone;
  final String name;
  final bool profileCompleted;

  const UserEntity({
    required this.id,
    required this.phone,
    required this.name,
    required this.profileCompleted,
  });
}