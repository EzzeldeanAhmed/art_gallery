import 'package:art_gallery/core/models/exhibition_entity.dart';
import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/models/exhibition_entity.dart';
import 'package:art_gallery/core/repos/ticket_repo/ticket_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/core/utils/app_images.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';
import 'package:art_gallery/core/widgets/custom_network_image.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artwork_widgets/artwork_details_page.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/exhibtion_widgets/exhibition_book_popup.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/exhibtion_widgets/exhibition_details_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class ExhibitionItem extends StatelessWidget {
  const ExhibitionItem(
      {super.key, required this.exhibitionEntity, required this.filter});

  final ExhibitionEntity exhibitionEntity;
  final String filter;
  @override
  Widget build(BuildContext context) {
    String modifiedName = exhibitionEntity.name;
    int maxSize = 35;
    if (modifiedName.length > maxSize) {
      modifiedName = modifiedName.substring(0, maxSize) + "...";
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => ExhibitionDetailsPage(
                  exhibitionEntity: exhibitionEntity, filter: filter)),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                child: Image.network(
                  exhibitionEntity.imageUrl!,
                  width: 200,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exhibitionEntity.name,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Text(exhibitionEntity.startDate.toString(),
                          style: TextStyle(color: Colors.grey[600])),
                      SizedBox(height: 4),
                      Text(exhibitionEntity.location,
                          style: TextStyle(color: Colors.grey[600])),
                      SizedBox(height: 12),
                      filter == "past"
                          ? Text("")
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () async {
                                // Handle booking action
                                var ticketRepo = getIt.get<TicketRepo>();
                                var ticketCount = await ticketRepo
                                    .getTicketsByExhibitionId(
                                        exhibitionId: exhibitionEntity.id!)
                                    .then((value) =>
                                        value.fold((l) => 0, (r) => r.length));
                                showBookTicketPopup(context, exhibitionEntity,
                                    exhibitionEntity.capacity - ticketCount);
                              },
                              child: Text("Book a Ticket",
                                  style: TextStyle(color: Colors.white)),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
