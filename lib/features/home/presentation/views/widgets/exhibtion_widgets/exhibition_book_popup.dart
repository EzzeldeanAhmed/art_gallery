import 'dart:io';

import 'package:art_gallery/core/models/exhibition_entity.dart';
import 'package:art_gallery/core/repos/ticket_repo/ticket_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/exhibtion_widgets/exhibition_checkout.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/material.dart';

class BookTicketPopup extends StatefulWidget {
  BookTicketPopup(
      {Key? key, required this.exhibition, required this.availableTickets})
      : super(key: key);

  final ExhibitionEntity exhibition;
  final int availableTickets;
  @override
  _BookTicketPopupState createState() => _BookTicketPopupState();
}

class _BookTicketPopupState extends State<BookTicketPopup> {
  int ticketQuantity = 1;
  String exhibitionName = 'Exhibition';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Book Ticket'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Available tickets:'),
          Text(widget.availableTickets.toString()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Enter ticket quantity:'),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (ticketQuantity > 1) ticketQuantity--;
                      });
                    },
                  ),
                  Text(ticketQuantity.toString(),
                      style: TextStyle(fontSize: 18)),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        if (ticketQuantity < widget.availableTickets) {
                          ticketQuantity++;
                        }
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
              'Total: \$${(ticketQuantity * widget.exhibition.ticketPrice).toStringAsFixed(2)}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            var ticketRepo = getIt.get<TicketRepo>();
            var ticketCount = await ticketRepo
                .getTicketsByExhibitionId(exhibitionId: widget.exhibition.id!)
                .then((value) => value.fold((l) => 0, (r) => r.length));
            if (ticketCount >= widget.exhibition.capacity) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text("Tickets are sold out for this exhibition!")),
              );
              return;
            }
            Navigator.of(context).pop();
            _proceedToCheckout(context);
          },
          child: Text('Proceed to Checkout'),
        ),
      ],
    );
  }

  void _proceedToCheckout(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CheckoutPage(
          exhibition: widget.exhibition, ticketQuantity: ticketQuantity),
    ));
  }
}

void showBookTicketPopup(
    BuildContext context, ExhibitionEntity exhibition, int availableTickets) {
  showDialog(
    context: context,
    builder: (context) => BookTicketPopup(
      exhibition: exhibition,
      availableTickets: availableTickets,
    ),
  );
}
