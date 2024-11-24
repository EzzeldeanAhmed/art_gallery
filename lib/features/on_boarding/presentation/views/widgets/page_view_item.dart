import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:art_gallery/constants.dart';
import 'package:art_gallery/core/services/shared_preferences_singleton.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';
import 'package:art_gallery/features/auth/presentation/views/signin_view.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem(
      {super.key,
      required this.image,
      required this.backgroundImage,
      required this.subtitle,
      required this.title,
      required this.isVisible});

  final String image, backgroundImage;
  final String subtitle;
  final Widget title;

  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  backgroundImage,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SvgPicture.asset(
                  image,
                ),
              ),
              Visibility(
                visible: isVisible,
                child: GestureDetector(
                  onTap: () {
                    Prefs.setBool(kIsOnBoardingViewSeen, true);
                    Navigator.of(context)
                        .pushReplacementNamed(SigninView.routeName);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text('Skip',
                        style: TextStyles.regular13.copyWith(
                          color: const Color(0xFF949D9E),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        title,
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 37.0),
          child: Text(subtitle,
              textAlign: TextAlign.center,
              style: TextStyles.semiBold13.copyWith(
                color: const Color(0xFF4E5456),
              )),
        ),
      ],
    );
  }
}
