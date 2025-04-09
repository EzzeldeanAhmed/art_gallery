import 'dart:io';

class PaymentEntity {
  String? id;
  String? userId;
  double? amount;
  String? type;
  String? status;
  DateTime? date;
  String? paymentMethod;

  PaymentEntity(
      {this.id,
      this.userId,
      this.amount,
      this.type,
      this.status,
      this.date,
      this.paymentMethod});
}
