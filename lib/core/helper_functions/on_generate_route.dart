import 'package:art_gallery/features/manage_artwork/presentation/views/add_artwork_view.dart';
import 'package:art_gallery/features/dashboard/views/dashboard_view.dart';
import 'package:art_gallery/features/dashboard/views/widgets/selection_view.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artworks_view.dart';
import 'package:art_gallery/features/manage_artwork/presentation/views/widgets/artworks_update_search_page.dart';
import 'package:flutter/material.dart';
import 'package:art_gallery/features/auth/presentation/views/signin_view.dart';
import 'package:art_gallery/features/auth/presentation/views/signup_view.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/main_view.dart';
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

    case MainView.routeName:
      return MaterialPageRoute(builder: (context) => const MainView());

    case ArtworksView.routeName:
      return MaterialPageRoute(builder: (context) => const ArtworksView());

    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (context) => const OnBoardingView());

    case DashboardView.routeName:
      return MaterialPageRoute(builder: (context) => const DashboardView());

    case AddArtworkView.routeName:
      return MaterialPageRoute(builder: (context) => const AddArtworkView());

    case SelectionView.routeName:
      return MaterialPageRoute(builder: (context) => const SelectionView());

    // case ArtworksUpdateSearchPage.routeName:
    //   return MaterialPageRoute(
    //       builder: (context) => const ArtworksUpdateSearchPage());

    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
