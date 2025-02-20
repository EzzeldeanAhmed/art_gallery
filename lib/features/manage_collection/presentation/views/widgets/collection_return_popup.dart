import 'package:art_gallery/core/repos/artworks_repo/artworks_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:art_gallery/core/models/artwork_entity.dart';

class ReturnArtworkPopup extends StatefulWidget {
  ReturnArtworkPopup({Key? key, required this.artwork, required this.onReturn})
      : super(key: key);

  final ArtworkEntity artwork;

  final Function onReturn;

  @override
  _ReturnArtworkPopupState createState() => _ReturnArtworkPopupState();
}

class _ReturnArtworkPopupState extends State<ReturnArtworkPopup> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Return Artwork'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Are you sure you want to return this artwork?'),
          SizedBox(height: 10),
          Text('Artwork: ${widget.artwork.name}',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(
              'Borrowed Until: ${DateFormat('yyyy-MM-dd').format(widget.artwork.returnDate!)}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onReturn();
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Artwork returned successfully")),
            );
          },
          child: Text('Confirm'),
        ),
      ],
    );
  }
}

void showReturnArtworkPopup(
    BuildContext context, ArtworkEntity artwork, Function onReturn) {
  showDialog(
    context: context,
    builder: (context) =>
        ReturnArtworkPopup(artwork: artwork, onReturn: onReturn),
  );
}
