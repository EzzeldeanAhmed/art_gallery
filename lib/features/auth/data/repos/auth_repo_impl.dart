import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:art_gallery/constants.dart';
import 'package:art_gallery/core/errors/exceptions.dart';
import 'package:art_gallery/core/errors/failures.dart';
import 'package:art_gallery/core/services/data_service.dart';
import 'package:art_gallery/core/services/firebase_auth_service.dart';
import 'package:art_gallery/core/services/shared_preferences_singleton.dart';
import 'package:art_gallery/core/utils/backend_endpoint.dart';
//import 'package:art_gallery/core/utils/backend_endpoint.dart';

import 'package:art_gallery/features/auth/data/models/user_model.dart';
import 'package:art_gallery/features/auth/domain/entites/user_entity.dart';
import 'package:art_gallery/features/auth/domain/repos/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;

  AuthRepoImpl(
      {required this.databaseService, required this.firebaseAuthService});
  @override
  Future<Either<Failure, User>> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      var user = await firebaseAuthService.createUserWithEmailAndPassword(
          email: email, password: password);
      return right(user);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(
        ServerFailure(
          'Something went wrong, Try again Later.',
        ),
      );
    }
  }

//
  /* Future<void> deleteUser(User? user) async {
    if (user != null) {
      await firebaseAuthService.deleteUser();
    }
  } */

  @override
  Future<Either<Failure, User>> signinWithEmailAndPassword(
      String email, String password) async {
    try {
      var user = await firebaseAuthService.signInWithEmailAndPassword(
          email: email, password: password);
      return right(user);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log(
        'Exception in AuthRepoImpl.createUserWithEmailAndPassword: ${e.toString()}',
      );
      return left(
        ServerFailure(
          'Something went wrong, Try again Later.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> addUser(UserModel user) async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uId)
          .set(user.toMap());
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log(
        'Exception in AuthRepoImpl.createUserWithEmailAndPassword: ${e.toString()}',
      );
      return left(
        ServerFailure(
          'Something went wrong, Try again Later.',
        ),
      );
    }
  }

  @override
  Future<UserEntity> getUserData({required String uid}) async {
    var userData = await databaseService.getData(
        path: BackendEndpoint.getUsersData, docuementId: uid);
    return UserModel.fromJson(userData);
  }

  @override
  Future<void> addFavoriteArtwork(
      {required String uid, required String artworkId}) async {
    var user = await getUserData(uid: uid);
    user.favoriteArtworks.add(artworkId);
    await databaseService.addData(
      path: BackendEndpoint.getUsersData,
      data: UserModel.fromEntity(user).toMap(),
      documentId: uid,
    );
  }

  @override
  Future<void> removeFavoriteArtwork(
      {required String uid, required String artworkId}) async {
    var user = await getUserData(uid: uid);
    user.favoriteArtworks.remove(artworkId);
    await databaseService.addData(
      path: BackendEndpoint.getUsersData,
      data: UserModel.fromEntity(user).toMap(),
      documentId: uid,
    );
  }

  @override
  Future saveUserData({required UserEntity user}) async {
    var jsonData = jsonEncode(UserModel.fromEntity(user).toMap());
    await Prefs.setString("loggedin_user", jsonData);
  }

  @override
  UserEntity getSavedUserData() {
    var jsonData = Prefs.getString("loggedin_user");
    if (jsonData != null && jsonData.isNotEmpty) {
      var user = UserModel.fromJson(jsonDecode(jsonData));
      return user;
    } else {
      throw Exception("No user data found");
    }
  }

  @override
  Future<List<UserModel>> getUsersData({required List<String> uids}) async {
    try {
      var data = await databaseService
          .getData(path: BackendEndpoint.getUsersData, query: {
        'where': {'attribute': FieldPath.documentId, 'in': uids}
      }) as List<Map<String, dynamic>>;
      List<UserModel> users = data.map((e) => UserModel.fromJson(e)).toList();

      return users;
    } catch (e) {
      throw ServerFailure('Failed to get artworks');
    }
  }

  @override
  Future<void> deleteSavedUserData() async {
    // TODO: implement deleteSavedUserData
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedin_user');
  }
}

/*  @override
  Future addUserData({required UserEntity user}) async {
    await databaseService.addData(
      path: BackendEndpoint.addUserData,
      data: UserModel.fromEntity(user).toMap(),
      documentId: user.uId,
    );
  } */
/* 

 


  @override
  Future addUserData({required UserEntity user}) async {
    await databaseService.addData(
      path: BackendEndpoint.addUserData,
      data: UserModel.fromEntity(user).toMap(),
      documentId: user.uId,
    );
  }

 

  
}
 */