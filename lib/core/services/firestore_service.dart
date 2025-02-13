import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:art_gallery/features/auth/data/models/user_model.dart';
import 'package:art_gallery/features/auth/domain/entites/user_entity.dart';

import 'data_service.dart';

class FireStoreService implements DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<void> addData(
      {required String path,
      required Map<String, dynamic> data,
      String? documentId}) async {
    if (documentId != null) {
      firestore.collection(path).doc(documentId).set(data);
    } else {
      await firestore.collection(path).add(data);
    }
  }

  @override
  Future<dynamic> getData(
      {required String path,
      String? docuementId,
      Map<String, dynamic>? query}) async {
    if (docuementId != null) {
      var data = await firestore.collection(path).doc(docuementId).get();
      return data.data();
    } else {
      Query<Map<String, dynamic>> data = firestore.collection(path);
      if (query != null) {
        if (query['orderBy'] != null) {
          var orderByField = query['orderBy'];
          var descending = query['descending'];
          data = data.orderBy(orderByField, descending: descending);
        }
        if (query['limit'] != null) {
          var limit = query['limit'];
          data = data.limit(limit);
        }
        if (query['where'] != null) {
          var where = query['where'];
          if (where['lessThan'] != null) {
            data =
                data.where(where['attribute'], isLessThan: where['lessThan']);
          }
          if (where['greaterThan'] != null) {
            data = data.where(where['attribute'],
                isGreaterThan: where['greaterThan']);
          }
          if (where['isBetween'] != null) {
            data = data.where(where['attribute'],
                isGreaterThan: where['isBetween'][0],
                isLessThan: where['isBetween'][1]);
          }
        }
      }
      var result = await data.get();
      var ret = result.docs.map((e) {
        var res = e.data();
        res['id'] = e.id;
        return res;
      }).toList();
      return ret;
    }
  }

  @override
  Future<dynamic> getDataWhere(
      {required String path,
      required String attribute,
      required String value,
      Map<String, dynamic>? query}) async {
    Query<Map<String, dynamic>> data =
        firestore.collection(path).where(attribute, isEqualTo: value);
    if (query != null) {
      if (query['orderBy'] != null) {
        var orderByField = query['orderBy'];
        var descending = query['descending'];
        data = data.orderBy(orderByField, descending: descending);
      }
      if (query['limit'] != null) {
        var limit = query['limit'];
        data = data.limit(limit);
      }
    }
    var result = await data.get();
    var ret = result.docs.map((e) {
      var res = e.data();
      res['id'] = e.id;
      return res;
    }).toList();
    return ret;
  }

  @override
  Future<bool> checkIfDataExists(
      {required String path, required String docuementId}) async {
    var data = await firestore.collection(path).doc(docuementId).get();
    return data.exists;
  }

  @override
  Future<void> deleteData(
      {required String path, required String documentId}) async {
    await firestore.collection(path).doc(documentId).delete();
  }
}
