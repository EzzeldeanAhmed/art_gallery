import 'package:art_gallery/core/models/exhibition_entity.dart';
import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/repos/artworks_repo/artworks_repo.dart';
import 'package:art_gallery/core/repos/exhibtion_repo/exhibition_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'exhibitions_state.dart';

class ExhibitionCubit extends Cubit<ExhibitionsState> {
  ExhibitionCubit(this.exhibitionsRepo) : super(ExhibitionsInitial());

  final ExhibitionRepo exhibitionsRepo;
  Future<void> getExhibitions({required String filter}) async {
    emit(ExhibitionsLoading());
    final result = await exhibitionsRepo.getExhibitionsFilter(filter);

    result.fold(
      (failure) => emit(ExhibitionsFailure(failure.message)),
      (exhibitions) => emit(ExhibitionsSuccess(exhibitions)),
    );
  }
}
