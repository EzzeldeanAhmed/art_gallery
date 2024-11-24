import 'package:flutter/material.dart';
import 'package:art_gallery/features/auth/presentation/views/signin_view.dart';
import 'package:art_gallery/features/auth/presentation/views/signup_view.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/home_view.dart';
import 'package:art_gallery/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:art_gallery/features/splash/presentation/views/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());

    case SigninView.routeName:
      return MaterialPageRoute(builder: (context) => const SigninView());

    case SignupView.routeName:
      return MaterialPageRoute(builder: (context) => const SignupView());

    case HomeView.routeName:
      return MaterialPageRoute(builder: (context) => const HomeView());

    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (context) => const OnBoardingView());

    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
