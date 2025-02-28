import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/models/artwork_model.dart';
import 'package:art_gallery/core/repos/artworks_repo/artworks_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:flutter/material.dart';
import 'package:art_gallery/core/models/order_model.dart';
import 'package:art_gallery/core/widgets/custom_network_image.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';
import 'package:art_gallery/core/utils/app_colors.dart';

class OrderDetailsPage extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsPage({Key? key, required this.order}) : super(key: key);

  Future<List<ArtworkEntity>> getArtwork(artworksId) async {
    var artworkRepo = getIt.get<ArtworksRepo>();
    List<ArtworkEntity> artworks = [];
    var data = await artworkRepo.getArtworksByIds(ids: artworksId);
    data.fold(
      (l) => print(l.message),
      (r) => artworks = r,
    );
    return artworks;
  }

  @override
  Widget build(BuildContext context) {
    var artworkIds = order.orderItems.map((e) => e.artworkId).toList();
    var total = order.orderItems
        .fold(0.0, (previousValue, element) => previousValue + element.price);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Order Details",
          style: TextStyles.bold23.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.lightPrimaryColor,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order Status:",
                        style: TextStyles.bold16,
                      ),
                      Text(
                        order.orderStatus,
                        style: TextStyles.bold16.copyWith(
                          color: order.orderStatus == "Completed"
                              ? Colors.green
                              : order.orderStatus == "Pending"
                                  ? Colors.orange
                                  : Colors.red,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),

                  // Order Date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order Date:",
                        style: TextStyles.bold16,
                      ),
                      Text(
                        order.orderDate,
                        style:
                            TextStyles.regular16.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),

                  // Contact Number
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Contact:",
                        style: TextStyles.bold16,
                      ),
                      Text(
                        order.phone,
                        style:
                            TextStyles.regular16.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),

                  // Address
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Address:",
                        style: TextStyles.bold16,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          order.streetAddress,
                          textAlign: TextAlign.end,
                          style: TextStyles.regular16
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  // Address
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Full Name:",
                        style: TextStyles.bold16,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          order.fullName,
                          textAlign: TextAlign.end,
                          style: TextStyles.regular16
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Order Items",
              style: TextStyles.bold19.copyWith(color: AppColors.primaryColor),
            ),
            SizedBox(height: 10),
            Expanded(
                child: FutureBuilder(
                    future: getArtwork(artworkIds),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done ||
                          snapshot.data!.length != artworkIds.length) {
                        return Container();
                      }
                      var orders = snapshot.data!;
                      return ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          var item = orders[index];
                          var price = order.orderItems
                              .firstWhere(
                                  (element) => element.artworkId == item.id)
                              .price;
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: SizedBox(
                                width: 50,
                                height: 50,
                                child: CustomNetworkImage(
                                    imageUrl: item.imageUrl!),
                              ),
                              title: Text(
                                item.name,
                                style: TextStyles.bold16
                                    .copyWith(color: Colors.black),
                              ),
                              subtitle: Text(
                                "${item.type}",
                                style: TextStyles.semiBold16
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                              trailing: Text(
                                "\$${price.toStringAsFixed(2)}",
                                style: TextStyles.bold19,
                              ),
                            ),
                          );
                        },
                      );
                    })),
            SizedBox(height: 15),

            // Total Price Section
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Amount:",
                    style: TextStyles.bold19.copyWith(color: Colors.black),
                  ),
                  Text(
                    "\$${total.toStringAsFixed(2)}",
                    style: TextStyles.bold19.copyWith(color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
