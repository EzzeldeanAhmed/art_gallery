import 'dart:ffi';

class UserEntity {
  String name;
  String email;
  String phone;
  String birthDate;
  String uId;
  String role;
  // favoriteArtworks
  List<dynamic> favoriteArtworks = [];

  UserEntity(
      {required this.name,
      required this.email,
      required this.phone,
      required this.birthDate,
      required this.uId,
      required this.role,
      required this.favoriteArtworks});
}
