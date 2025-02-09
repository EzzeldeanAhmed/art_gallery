import 'package:art_gallery/features/auth/data/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:art_gallery/features/auth/domain/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../domain/entites/user_entity.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit(this.authRepo) : super(SigninInitial());
  final AuthRepo authRepo;

  Future<void> signin(String email, String password) async {
    emit(SigninLoading());
    var result = await authRepo.signinWithEmailAndPassword(
      email,
      password,
    );
    result.fold(
      (failure) => emit(SigninFailure(message: failure.message)),
      (userEntity) async {
        UserEntity user = await authRepo.getUserData(uid: userEntity.uid);
        authRepo.saveUserData(user: user);
        emit(SigninSuccess(userEntity: user));
      },
    );
  }
}
