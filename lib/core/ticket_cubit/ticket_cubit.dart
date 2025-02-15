import 'package:art_gallery/core/models/ticket_entity.dart';
import 'package:art_gallery/core/repos/ticket_repo/ticket_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  TicketCubit(this.ticketsRepo) : super(TicketInitial());

  final TicketRepo ticketsRepo;
  Future<void> getTickets() async {
    emit(TicketLoading());
    final result = await ticketsRepo.getTickets();
    result.fold(
      (failure) => emit(TicketFailure(failure.message)),
      (tickets) => emit(TicketSuccess(tickets)),
    );
  }

  Future<void> getTicketsByUserId({required String userId}) async {
    emit(TicketLoading());
    final result = await ticketsRepo.getTicketsByUserId(userId);
    result.fold(
      (failure) => emit(TicketFailure(failure.message)),
      (tickets) => emit(TicketSuccess(tickets)),
    );
  }

  Future<void> addTicket({required TicketEntity ticket}) async {
    emit(TicketLoading());
    final result = await ticketsRepo.addTicket(ticket);
    result.fold(
      (failure) => emit(TicketFailure(failure.message)),
      (_) => emit(TicketSuccess([])),
    );
  }
}
