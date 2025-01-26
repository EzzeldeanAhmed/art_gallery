import '../../features/auth/domain/entites/user_entity.dart';

abstract class DatabaseService {
  Future<void> addData(
      {required String path,
      required Map<String, dynamic> data,
      String? documentId});
  Future<dynamic> getData({
    required String path,
    String? docuementId,
    Map<String, dynamic>? query,
  });
  Future<dynamic> getDataWhere(
      {required String path,
      required String attribute,
      required String value,
      Map<String, dynamic>? query});
  Future<void> deleteData({required String path, required String documentId});

  Future<bool> checkIfDataExists(
      {required String path, required String docuementId});
}
