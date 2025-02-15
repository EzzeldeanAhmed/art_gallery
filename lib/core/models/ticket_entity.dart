import 'package:cloud_firestore/cloud_firestore.dart';

class TicketEntity {
  final String userId;
  final String exhibitionId;
  final DateTime bookedDate;
  final int quantity;

  TicketEntity(
      {required this.userId,
      required this.exhibitionId,
      required this.bookedDate,
      required this.quantity});
}
