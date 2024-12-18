import 'dart:io';
import 'package:art_gallery/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ImagesRepo {
  Future<Either<Failure, String>> UploadImage(File image);
}
