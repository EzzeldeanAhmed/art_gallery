import 'package:art_gallery/core/artwork_cubit/artworks_cubit.dart';
import 'package:art_gallery/core/cart_cubit/cart_cubit.dart';
import 'package:art_gallery/core/repos/artworks_repo/artworks_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/features/auth/domain/repos/auth_repo.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/cart_widgets/cart_checkout.dart';
import 'package:flutter/material.dart';
import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';
import 'package:art_gallery/core/widgets/custom_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  CartPage({Key? key}) : super(key: key);

  List<String> cartItems = [];
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    var userId = getIt.get<AuthRepo>().getSavedUserData().uId;
    context.read<CartCubit>().getCart(userId);
    super.initState();
  }

  void removeFromCart(ArtworkEntity artwork) {
    setState(() {
      widget.cartItems.remove(artwork);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${artwork.name} removed from cart!")),
    );
  }

  Future<ArtworkEntity?> getArtwork(artworkId) async {
    var artworkRepo = getIt.get<ArtworksRepo>();
    var result = await artworkRepo.getArtworkById(artworkId);
    var artwork = result.fold((l) => null, (r) => r);
    return artwork;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartSuccess) {
          widget.cartItems = state.cart.artworksID;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Cart',
                style: TextStyles.bold23.copyWith(color: Colors.black),
              ),
            ),
            body: widget.cartItems.isEmpty
                ? Center(
                    child: Text(
                      "Your cart is empty",
                      style: TextStyles.bold19.copyWith(color: Colors.black),
                    ),
                  )
                : ListView.builder(
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      final artworkId = widget.cartItems[index];
                      return FutureBuilder(
                          future: getArtwork(artworkId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return Container();
                            }
                            var artwork = snapshot.data;
                            return Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: ListTile(
                                leading: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CustomNetworkImage(
                                      imageUrl: artwork!.imageUrl!),
                                ),
                                title: Text(
                                  artwork.name,
                                  style: TextStyles.semiBold16.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                subtitle: Text(
                                  artwork.type,
                                  style: TextStyles.regular16.copyWith(
                                    color: AppColors.secondaryColor,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.remove_circle,
                                      color: Colors.red),
                                  onPressed: () => removeFromCart(artwork),
                                ),
                              ),
                            );
                          });
                    },
                  ),
            bottomNavigationBar: widget.cartItems.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement checkout logic
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CartCheckoutPage(
                            cartModel: state.cart,
                          ),
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Checkout",
                        style: TextStyles.bold16.copyWith(color: Colors.white),
                      ),
                    ),
                  )
                : null,
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
