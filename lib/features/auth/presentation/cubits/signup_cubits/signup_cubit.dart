import 'package:art_gallery/features/auth/data/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:art_gallery/features/auth/domain/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../domain/entites/user_entity.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());

  final AuthRepo authRepo;

  Future<void> createUserWithEmailAndPassword(String email, String password,
      String name, String phone, String birthDate) async {
    emit(SignupLoading());
    final result =
        await authRepo.createUserWithEmailAndPassword(email, password, name);

    result.fold((failure) async {
      emit(
        SignupFailure(message: failure.message),
      );
    }, (userEntity) async {
      await authRepo.addUser(UserModel(
          name: name,
          email: email,
          phone: phone,
          birthDate: birthDate,
          uId: userEntity.uid,
          role: "client",
          favoriteArtworks: []));
      emit(
        SignupSuccess(userEntity: userEntity),
      );
    });
  }
}
