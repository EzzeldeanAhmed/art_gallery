import 'package:art_gallery/core/repos/artworks_repo/artworks_repo.dart';
import 'package:art_gallery/core/repos/collection_repo/collection_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/core/widgets/custom_error_widget.dart';
import 'package:art_gallery/features/manage_collection/presentation/views/manger/get_collections/cubit/get_collection_cubit.dart';
import 'package:art_gallery/features/manage_collection/presentation/views/widgets/collections_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionsView extends StatelessWidget {
  const CollectionsView({super.key});
  static const routeName = 'CollectionsView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetCollectionCubit(
        getIt.get<CollectionsRepo>(),
        getIt.get<ArtworksRepo>(),
      ),
      child: CollectionsListViewState(),
    );
  }
}

class CollectionsListViewState extends StatefulWidget {
  @override
  State<CollectionsListViewState> createState() =>
      _CollectionsListViewStateState();
}

class _CollectionsListViewStateState extends State<CollectionsListViewState> {
  void initState() {
    context.read<GetCollectionCubit>().getCollectionArtworks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCollectionCubit, GetCollectionState>(
        builder: (context, state) {
      if (state is GetCollectionSuccess) {
        return CollectionsListView(
          collections: state.collections,
        );
      } else if (state is GetCollectionFailure) {
        return SliverToBoxAdapter(
            child: CustomErrorWidget(text: state.errMessage));
      } else {
        return CollectionsListView(
          collections: [],
        );
      }
    });
  }
}
