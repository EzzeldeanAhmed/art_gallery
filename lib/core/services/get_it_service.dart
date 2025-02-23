import 'package:art_gallery/core/repos/artist_repo/artist_repo.dart';
import 'package:art_gallery/core/repos/artist_repo/artist_repo_impl.dart';
import 'package:art_gallery/core/repos/artworks_repo/artworks_repo.dart';
import 'package:art_gallery/core/repos/artworks_repo/artworks_repo_impl.dart';
import 'package:art_gallery/core/repos/cart_repo/cart_repo.dart';
import 'package:art_gallery/core/repos/cart_repo/cart_repo_impl.dart';
import 'package:art_gallery/core/repos/collection_repo/collection_repo.dart';
import 'package:art_gallery/core/repos/collection_repo/collection_repo_impl.dart';
import 'package:art_gallery/core/repos/exhibtion_repo/exhibition_repo.dart';
import 'package:art_gallery/core/repos/exhibtion_repo/exhibition_repo_impl.dart';
import 'package:art_gallery/core/repos/images_repo/images_repo.dart';
import 'package:art_gallery/core/repos/images_repo/images_repo_impl.dart';
import 'package:art_gallery/core/repos/order_repo/order_repo.dart';
import 'package:art_gallery/core/repos/order_repo/order_repo_impl.dart';
import 'package:art_gallery/core/repos/ticket_repo/ticket_repo.dart';
import 'package:art_gallery/core/repos/ticket_repo/ticket_repo_impl.dart';
import 'package:art_gallery/core/services/data_service.dart';
import 'package:art_gallery/core/services/fire_storage.dart';
import 'package:art_gallery/core/services/firebase_auth_service.dart';
import 'package:art_gallery/core/services/firestore_service.dart';
import 'package:art_gallery/core/services/storage_service.dart';
import 'package:art_gallery/features/auth/data/repos/auth_repo_impl.dart';
import 'package:art_gallery/features/auth/domain/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetit() {
  // getIt.registerSingleton<StorageService>(FireStorage());
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<DatabaseService>(FireStoreService());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      firebaseAuthService: getIt<FirebaseAuthService>(),
      databaseService: getIt<DatabaseService>(),
    ),
  );
  getIt.registerSingleton<ArtworksRepo>(
    ArtworksRepoImpl(
      getIt<DatabaseService>(),
    ),
  );
  getIt.registerSingleton<ArtistsRepo>(
    ArtistRepoImpl(
      getIt<DatabaseService>(),
    ),
  );
  getIt.registerSingleton<ExhibitionRepo>(
    ExhibitionRepoImpl(
      getIt<DatabaseService>(),
    ),
  );

  getIt.registerSingleton<TicketRepo>(
    TicketRepoImpl(
      getIt<DatabaseService>(),
    ),
  );

  getIt.registerSingleton<CollectionsRepo>(
    CollectionRepoImpl(
      getIt<DatabaseService>(),
    ),
  );
  getIt.registerSingleton<CartRepo>(
    CartRepoImpl(
      getIt<DatabaseService>(),
    ),
  );

  getIt.registerSingleton<OrderRepo>(
    OrderRepoImpl(
      getIt<DatabaseService>(),
    ),
  );
  getIt.registerSingleton<ImagesRepo>(ImagesRepoImpl());
}
