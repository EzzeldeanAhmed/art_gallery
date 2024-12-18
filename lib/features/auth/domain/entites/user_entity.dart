class UserEntity {
  final String name;
  final String email;
  final String phone;
  final String birthDate;
  final String uId;
  final String role;

  UserEntity(
      {required this.name,
      required this.email,
      required this.phone,
      required this.birthDate,
      required this.uId,
      required this.role});
}
