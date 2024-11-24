import 'package:flutter/material.dart';
import 'package:art_gallery/features/on_boarding/presentation/views/widgets/on_boarding_view_body.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  static const String routeName = 'onBoardingView';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: OnBoardingViewBody()),
    );
  }
}
