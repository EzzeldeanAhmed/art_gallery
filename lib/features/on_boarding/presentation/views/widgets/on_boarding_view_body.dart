import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:art_gallery/constants.dart';
import 'package:art_gallery/core/services/shared_preferences_singleton.dart';
import 'package:art_gallery/core/widgets/custom_button.dart';
import 'package:art_gallery/features/auth/presentation/views/signin_view.dart';
import 'package:art_gallery/features/on_boarding/presentation/views/widgets/on_boarding_page_view.dart';
import 'package:art_gallery/core/utils/app_colors.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  late PageController pageController;
  var currentPage = 0;

  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(() {
      currentPage = pageController.page!.round();
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: OnBoardingPageView(
            pageController: pageController,
          ),
        ),
        DotsIndicator(
          dotsCount: 2,
          decorator: DotsDecorator(
            activeColor: AppColors.primaryColor,
            color: currentPage == 1
                ? AppColors.primaryColor
                : AppColors.primaryColor.withOpacity(0.5),
          ),
        ),
        const SizedBox(height: 29),
        Visibility(
          visible: currentPage == 1 ? true : false,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: CustomButton(
              onPressed: () {
                Prefs.setBool(kIsOnBoardingViewSeen, true);
                Navigator.of(context)
                    .pushReplacementNamed(SigninView.routeName);
              },
              text: ("Start Now"),
            ),
          ),
        ),
        const SizedBox(height: 43),
      ],
    );
  }
}
