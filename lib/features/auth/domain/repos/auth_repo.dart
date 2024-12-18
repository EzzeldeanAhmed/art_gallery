import 'package:art_gallery/features/auth/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:art_gallery/core/errors/failures.dart';

import '../entites/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, User>> createUserWithEmailAndPassword(
      String email, String password, String name);

  Future<Either<Failure, User>> signinWithEmailAndPassword(
      String email, String password);

  Future<Either<Failure, void>> addUser(UserModel user);

  Future<UserEntity> getUserData({required String uid});
}


/*
  Future addUserData({required UserEntity user});
  Future saveUserData({required UserEntity user});
  */
//}
