import 'package:art_gallery/core/artwork_cubit/artworks_cubit.dart';
import 'package:art_gallery/core/cart_cubit/cart_cubit.dart';
import 'package:art_gallery/core/models/cart_model.dart';
import 'package:art_gallery/core/order_cubit/order_cubit.dart';
import 'package:art_gallery/core/repos/artworks_repo/artworks_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/features/auth/domain/repos/auth_repo.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/cart_widgets/cart_checkout.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/order_widgets/order_details_page.dart';
import 'package:flutter/material.dart';
import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';
import 'package:art_gallery/core/widgets/custom_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key? key}) : super(key: key);

  // List<String> cartItems = [];
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    var userId = getIt.get<AuthRepo>().getSavedUserData().uId;
    context.read<OrderCubit>().getOrder(userId);
    super.initState();
  }

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
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is OrderSuccess) {
          var orders = state.order;
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Your Orders',
                  style: TextStyles.bold23.copyWith(color: Colors.white),
                ),
                centerTitle: true,
                backgroundColor: AppColors.lightPrimaryColor,
                elevation: 1,
              ),
              body: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  var order = orders[index];
                  double totalPrice = 0;
                  for (var element in order.orderItems) {
                    totalPrice += element.price;
                  }
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(
                        "Order #${order.id}",
                        style: TextStyles.bold16
                            .copyWith(color: AppColors.primaryColor),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total: \$${totalPrice.toStringAsFixed(2)}",
                            style: TextStyles.semiBold16
                                .copyWith(color: Colors.black),
                          ),
                          Text(
                            "Status: ${order.orderStatus}",
                            style: TextStyles.regular16
                                .copyWith(color: AppColors.secondaryColor),
                          ),
                          Text(
                            "Date: ${order.orderDate}",
                            style: TextStyles.regular16
                                .copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                      trailing:
                          Icon(Icons.arrow_forward_ios, color: Colors.grey),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OrderDetailsPage(order: order),
                          ),
                        );
                      },
                    ),
                  );
                },
              ));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
