import 'package:art_gallery/core/errors/failures.dart';
import 'package:art_gallery/core/models/ticket_entity.dart';
import 'package:art_gallery/core/models/ticket_model.dart';
import 'package:art_gallery/core/repos/ticket_repo/ticket_repo.dart';
import 'package:art_gallery/core/services/data_service.dart';
import 'package:art_gallery/core/utils/backend_endpoint.dart';
import 'package:dartz/dartz.dart';

class TicketRepoImpl implements TicketRepo {
  final DatabaseService databaseService;

  TicketRepoImpl(this.databaseService);

  @override
  Future<Either<Failure, List<TicketEntity>>> getTickets() async {
    try {
      var data = await databaseService.getData(path: BackendEndpoint.getArtists)
          as List<Map<String, dynamic>>;

      List<TicketEntity> tickets =
          data.map((e) => TicketModel.fromJson(e).toEntity()).toList();
      return right(tickets);
    } catch (e) {
      return Left(ServerFailure('Failed to get tickets'));
    }
  }

  @override
  Future<Either<Failure, void>> addTicket(TicketEntity ticket) async {
    try {
      var data = TicketModel.fromEntity(ticket).toJson();
      databaseService.addData(path: BackendEndpoint.getTickets, data: data);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to add ticket'));
    }
  }

  @override
  Future<Either<Failure, List<TicketEntity>>> getTicketsByUserId(
      String userId) async {
    try {
      var data = await databaseService
          .getData(path: BackendEndpoint.getTickets, query: {
        'where': {'attribute': 'userId', 'equalTo': userId}
      }) as List<Map<String, dynamic>>;
      List<TicketEntity> tickets =
          data.map((e) => TicketModel.fromJson(e).toEntity()).toList();
      return right(tickets);
    } catch (e) {
      return Left(ServerFailure('Failed to get tickets'));
    }
  }

  @override
  Future<Either<Failure, List<TicketEntity>>> getTicketsByExhibitionId(
      {required String exhibitionId}) async {
    try {
      var data = await databaseService
          .getData(path: BackendEndpoint.getTickets, query: {
        'where': {'attribute': 'exhibitionId', 'equalTo': exhibitionId}
      }) as List<Map<String, dynamic>>;
      List<TicketEntity> tickets =
          data.map((e) => TicketModel.fromJson(e).toEntity()).toList();
      return right(tickets);
    } catch (e) {
      return Left(ServerFailure('Failed to get tickets'));
    }
  }
}
