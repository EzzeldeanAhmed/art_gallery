import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg;
//import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg;
import 'package:art_gallery/core/utils/app_images.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/featured_item_button.dart';
import 'package:svg_flutter/svg.dart';
import 'package:svg_flutter/svg_flutter.dart';

class FeaturedItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final String buttonAction;

  const FeaturedItem(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.image,
      required this.buttonAction});

  @override
  Widget build(BuildContext context) {
    var itemWidth = MediaQuery.sizeOf(context).width - 32;
    return ClipRRect(
      //borderRadius: BorderRadius.circular(4),
      child: SizedBox(
        width: itemWidth,
        child: AspectRatio(
          aspectRatio: 342 / 158,
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                left: itemWidth * .4,
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: itemWidth * .5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: svg.Svg(Assets.imagesFeaturedItemBackground),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 33,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        title,
                        style: TextStyles.regular13.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        subtitle,
                        style: TextStyles.bold19.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      FeaturedItemButton(
                        onPressed: () {},
                      ),
                      const SizedBox(
                        height: 29,
                      ),
                    ],
                    //.....
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
