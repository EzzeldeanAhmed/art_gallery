import 'package:art_gallery/features/dashboard/views/widgets/dashboard_operations.dart';
import 'package:art_gallery/features/dashboard/views/widgets/system_basic_entites.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artist_widgets/artist_view.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/exhibtion_widgets/exhibition_view.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/profile/booked_tickets/tickets.dart';
import 'package:art_gallery/features/manage_artist/presentation/views/artist_dashboard_view.dart';
import 'package:art_gallery/features/manage_artwork/presentation/views/add_artwork_view.dart';
import 'package:art_gallery/features/manage_artwork/presentation/views/artwork_dashboard_view.dart';
import 'package:art_gallery/features/dashboard/views/widgets/selection_view.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artwork_widgets/artworks_view.dart';
import 'package:art_gallery/features/manage_artwork/presentation/views/widgets/artworks_update_search_page.dart';
import 'package:art_gallery/features/manage_exhibition/presentation/views/add_exhibition_view.dart';
import 'package:art_gallery/features/manage_exhibition/presentation/views/exhibition_dashboard_view.dart';
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

    case ArtistView.routeName:
      return MaterialPageRoute(builder: (context) => const ArtistView());

    case ExhibitionsView.routeName:
      return MaterialPageRoute(builder: (context) => const ExhibitionsView());

    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (context) => const OnBoardingView());

    case ArtworkDashboardView.routeName:
      return MaterialPageRoute(
          builder: (context) => const ArtworkDashboardView());

    case ArtistDashboardView.routeName:
      return MaterialPageRoute(
          builder: (context) => const ArtistDashboardView());

    case AddArtworkView.routeName:
      return MaterialPageRoute(builder: (context) => const AddArtworkView());

    case ExhibitionDashboardView.routeName:
      return MaterialPageRoute(
          builder: (context) => const ExhibitionDashboardView());

    case AddExhibitionView.routeName:
      return MaterialPageRoute(builder: (context) => const AddExhibitionView());

    case SelectionView.routeName:
      return MaterialPageRoute(builder: (context) => const SelectionView());

    case DashboardOperations.routeName:
      return MaterialPageRoute(
          builder: (context) => const DashboardOperations());

    case SystemBasicEntites.routeName:
      return MaterialPageRoute(
          builder: (context) => const SystemBasicEntites());

    case TicketListScreen.routeName:
      return MaterialPageRoute(builder: (context) => TicketListScreen());

    // case ArtworksUpdateSearchPage.routeName:
    //   return MaterialPageRoute(
    //       builder: (context) => const ArtworksUpdateSearchPage());

    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
