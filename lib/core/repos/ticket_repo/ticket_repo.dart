import 'package:art_gallery/core/errors/failures.dart';
import 'package:art_gallery/core/models/ticket_entity.dart';
import 'package:dartz/dartz.dart';

abstract class TicketRepo {
  Future<Either<Failure, List<TicketEntity>>> getTickets();
  Future<Either<Failure, List<TicketEntity>>> getTicketsByUserId(String userId);
  Future<Either<Failure, List<TicketEntity>>> getTicketsByExhibitionId(
      {required String exhibitionId});
  Future<Either<Failure, void>> addTicket(TicketEntity ticket);
}
