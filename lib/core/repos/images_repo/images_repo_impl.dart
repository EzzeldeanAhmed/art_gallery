import 'dart:io';

import 'package:art_gallery/core/errors/failures.dart';
import 'package:art_gallery/core/repos/images_repo/images_repo.dart';
import 'package:art_gallery/core/services/storage_service.dart';
import 'package:art_gallery/main.dart';
import 'package:dartz/dartz.dart';
import 'package:path/path.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class ImagesRepoImpl implements ImagesRepo {
  ImagesRepoImpl();
  @override
  Future<Either<Failure, String>> UploadImage(File image) async {
    try {
      final String name = Uuid().v4();
      final String url = await supabase.storage.from("images").upload(
            name,
            image,
          );
      final String public_url =
          await supabase.storage.from("images").getPublicUrl(name);
      // String url =
      //     await storageService.uploadFile(image, BackendEndpoint.images);
      return Right(public_url);
    } catch (e) {
      return Left(ServerFailure('Failed to upload image'));
    }
  }
}
