import 'package:art_gallery/core/models/ticket_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TicketModel {
  final String userId;
  final String exhibitionId;
  final DateTime bookedDate;
  final int quantity;
  String? ticketId; // Optional field for ticket ID
  TicketModel({
    required this.userId,
    required this.exhibitionId,
    required this.bookedDate,
    required this.quantity,
    this.ticketId,
  });

  factory TicketModel.fromEntity(TicketEntity ticketEntity) {
    return TicketModel(
      userId: ticketEntity.userId,
      exhibitionId: ticketEntity.exhibitionId,
      bookedDate: ticketEntity.bookedDate,
      quantity: ticketEntity.quantity,
      ticketId: ticketEntity.ticketId, // Optional field
    );
  }

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      userId: json['userId'],
      exhibitionId: json['exhibitionId'],
      bookedDate: (json['bookedDate'] as Timestamp).toDate(),
      quantity: json['quantity'],
      ticketId: json['id'], // Optional field
    );
  }

  TicketEntity toEntity() {
    return TicketEntity(
      userId: userId,
      exhibitionId: exhibitionId,
      bookedDate: bookedDate,
      quantity: quantity,
      ticketId: ticketId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'exhibitionId': exhibitionId,
      'bookedDate': bookedDate,
      'quantity': quantity,
    };
  }
}
