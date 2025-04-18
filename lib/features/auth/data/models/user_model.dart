import 'package:firebase_auth/firebase_auth.dart';
import 'package:art_gallery/features/auth/domain/entites/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.name,
      required super.email,
      required super.phone,
      required super.birthDate,
      required super.uId,
      required super.role,
      required super.favoriteArtworks});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'],
        email: json['email'],
        uId: json['uId'],
        birthDate: json['birthDate'],
        phone: json['phone'],
        role: json['role'],
        favoriteArtworks: json['favoriteArtworks']);
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
        name: entity.name,
        email: entity.email,
        uId: entity.uId,
        birthDate: entity.birthDate,
        phone: entity.phone,
        role: entity.role,
        favoriteArtworks: entity.favoriteArtworks);
  }

  toMap() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
      'birthDate': birthDate,
      'phone': phone,
      'role': role,
      'favoriteArtworks': favoriteArtworks
    };
  }
}
