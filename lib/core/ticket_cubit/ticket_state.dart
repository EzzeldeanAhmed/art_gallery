part of 'ticket_cubit.dart';

@immutable
sealed class TicketState {}

final class TicketInitial extends TicketState {}

final class TicketLoading extends TicketState {}

final class TicketFailure extends TicketState {
  final String errMessage;

  TicketFailure(this.errMessage);
}

final class TicketSuccess extends TicketState {
  final List<TicketEntity> ticket;
  TicketSuccess(this.ticket);
}
