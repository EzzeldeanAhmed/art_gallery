import 'package:art_gallery/core/repos/artworks_repo/artworks_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting the date
import 'package:art_gallery/core/models/artwork_entity.dart';

class BorrowArtworkPopup extends StatefulWidget {
  BorrowArtworkPopup({Key? key, required this.artwork, required this.onBorrow})
      : super(key: key);

  final ArtworkEntity artwork;
  final Function onBorrow;
  @override
  _BorrowArtworkPopupState createState() => _BorrowArtworkPopupState();
}

class _BorrowArtworkPopupState extends State<BorrowArtworkPopup> {
  DateTime? returnDate;

  Future<void> _selectReturnDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)), // Up to 1 year
    );

    if (picked != null && picked != returnDate) {
      setState(() {
        returnDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Borrow Artwork'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Artwork: ${widget.artwork.name}',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('Select return date:'),
          SizedBox(height: 5),
          GestureDetector(
            onTap: () => _selectReturnDate(context),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    returnDate == null
                        ? "Pick a date"
                        : DateFormat('yyyy-MM-dd').format(returnDate!),
                    style: TextStyle(fontSize: 16),
                  ),
                  Icon(Icons.calendar_today, color: Colors.grey),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (returnDate != null) {
              // Handle borrowing logic
              widget.onBorrow(returnDate!);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        "Artwork borrowed until ${DateFormat('yyyy-MM-dd').format(returnDate!)}")),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Please select a return date")),
              );
            }
          },
          child: Text('Confirm'),
        ),
      ],
    );
  }
}

void showBorrowArtworkPopup(
    BuildContext context, ArtworkEntity artwork, Function onBorrow) {
  showDialog(
    context: context,
    builder: (context) =>
        BorrowArtworkPopup(artwork: artwork, onBorrow: onBorrow),
  );
}
