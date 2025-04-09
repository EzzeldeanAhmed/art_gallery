import 'dart:io';

import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/payment_entity.dart';
import 'package:art_gallery/core/models/review_model.dart';

class PaymentModel {
  String? id;
  String? userId;
  double? amount;
  String? type;
  String? status;
  DateTime? date;
  String? paymentMethod;

  PaymentModel(
      {this.id,
      this.userId,
      this.amount,
      this.type,
      this.status,
      this.date,
      this.paymentMethod});

  factory PaymentModel.fromEntity(PaymentEntity addArtworkInputEntity) {
    return PaymentModel(
        id: addArtworkInputEntity.id,
        userId: addArtworkInputEntity.userId,
        amount: addArtworkInputEntity.amount,
        type: addArtworkInputEntity.type,
        status: addArtworkInputEntity.status,
        date: addArtworkInputEntity.date,
        paymentMethod: addArtworkInputEntity.paymentMethod);
  }

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'],
      userId: json['userId'],
      amount: json['amount']?.toDouble(),
      type: json['type'],
      status: json['status'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      paymentMethod: json['paymentMethod'],
    );
  }

  toJson() {
    return {
      'id': id,
      'userId': userId,
      'amount': amount,
      'type': type,
      'status': status,
      'date': date != null ? date!.toIso8601String() : null,
      'paymentMethod': paymentMethod,
    };
  }

  PaymentEntity toEntity() {
    return PaymentEntity(
        id: id,
        userId: userId,
        amount: amount,
        type: type,
        status: status,
        date: date,
        paymentMethod: paymentMethod);
  }
}
