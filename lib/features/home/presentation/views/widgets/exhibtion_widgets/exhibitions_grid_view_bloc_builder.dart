import 'package:art_gallery/core/exhibition_cubit/exhibitions_cubit.dart';
import 'package:art_gallery/core/exhibition_cubit/exhibitions_cubit.dart';
import 'package:art_gallery/core/widgets/custom_error_widget.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/exhibtion_widgets/exhibition_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ExhibitionsGridViewBlocBuilder extends StatelessWidget {
  const ExhibitionsGridViewBlocBuilder({super.key, required this.filter});
  final String filter;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExhibitionCubit, ExhibitionsState>(
        builder: (context, state) {
      if (state is ExhibitionsSuccess) {
        return state.exhibitions.isEmpty
            ? SliverToBoxAdapter(
                child: CustomErrorWidget(text: 'No exhibitions found'))
            : ExhibitionsGridView(
                exhibitions: state.exhibitions, filter: filter);
      } else if (state is ExhibitionsFailure) {
        return SliverToBoxAdapter(
            child: CustomErrorWidget(text: state.errMessage));
      } else {
        return Skeletonizer.sliver(
            enabled: true,
            child: const ExhibitionsGridView(
              exhibitions: [],
              filter: '',
            ));
      }
    });
  }
}
