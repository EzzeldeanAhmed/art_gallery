import 'package:art_gallery/core/errors/failures.dart';
import 'package:art_gallery/core/models/exhibition_entity.dart';
import 'package:art_gallery/core/repos/exhibtion_repo/exhibition_repo.dart';
import 'package:art_gallery/core/repos/ticket_repo/ticket_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/core/ticket_cubit/ticket_cubit.dart';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/core/widgets/custom_error_widget.dart';
import 'package:art_gallery/features/auth/domain/repos/auth_repo.dart';
import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TicketListScreen extends StatelessWidget {
  static const routeName = "ticket_screen";
  final List<Map<String, String>> tickets = [
    {
      'event': 'Concert Night',
      'date': 'Feb 20, 2025',
      'time': '7:00 PM',
      'location': 'Madison Square Garden',
      'seat': 'A12'
    },
    {
      'event': 'Basketball Match',
      'date': 'March 5, 2025',
      'time': '6:30 PM',
      'location': 'Staples Center',
      'seat': 'B22'
    },
    {
      'event': 'Tech Conference',
      'date': 'April 10, 2025',
      'time': '10:00 AM',
      'location': 'Silicon Valley Expo',
      'seat': 'VIP'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TicketCubit(
        getIt.get<TicketRepo>(),
      ),
      child: TicketList(tickets: tickets),
    );
  }
}

class TicketList extends StatefulWidget {
  const TicketList({
    super.key,
    required this.tickets,
  });

  final List<Map<String, String>> tickets;

  @override
  State<TicketList> createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> {
  void initState() {
    var user = getIt.get<AuthRepo>().getSavedUserData();
    context.read<TicketCubit>().getTicketsByUserId(userId: user.uId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketCubit, TicketState>(builder: (context, state) {
      if (state is TicketSuccess) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'My Tickets',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: AppColors.lightPrimaryColor,
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: state.ticket.length,
              itemBuilder: (context, index) {
                final ticket = state.ticket[index];
                return FutureBuilder<Either<Failure, ExhibitionEntity>>(
                    future: fetchExhibition(ticket.exhibitionId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center();
                      } else if (snapshot.hasError || !snapshot.hasData) {
                        return Center(child: Text("Failed to load exhibition"));
                      }
                      return snapshot.data!.fold(
                          (failure) =>
                              Center(child: Text("Error: ${failure.message}")),
                          (exhibition) => Card(
                                elevation: 4,
                                margin: EdgeInsets.symmetric(vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(15),
                                  title: Text(
                                    exhibition.name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      // Ticket ID
                                      Text(
                                        '🎟   Ticket ID: ${ticket.ticketId}',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '📅   Date: ${DateFormat('MMMM dd, yyyy').format(exhibition.startDate.toLocal())}',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '⏰   Time: ${DateFormat('hh:mm a').format(exhibition.startDate.toLocal())}',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      // Quantity
                                      SizedBox(height: 4),

                                      Text(
                                        '📈   Number of Vistors: ${ticket.quantity}',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(height: 4),

                                      Text(
                                        '📍   Location: ${exhibition.location}',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),

                                      // Text('🎟 Seat: ${ticket['seat']}'),
                                    ],
                                  ),
                                  leading: Icon(Icons.event,
                                      color: AppColors.lightPrimaryColor),
                                ),
                              ));
                    });
              },
            ),
          ),
        );
      } else if (state is TicketFailure) {
        return CustomErrorWidget(text: state.errMessage);
      } else {
        return Center(child: CircularProgressIndicator());
      }
    });
  }

  Future<Either<Failure, ExhibitionEntity>> fetchExhibition(String id) {
    return getIt.get<ExhibitionRepo>().getExhibition(id);
  }
}
