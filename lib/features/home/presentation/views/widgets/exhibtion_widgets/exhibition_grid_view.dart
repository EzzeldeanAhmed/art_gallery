import 'package:art_gallery/core/models/exhibition_entity.dart';
import 'package:art_gallery/core/models/exhibition_entity.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/core/widgets/exhibition_item.dart';
import 'package:art_gallery/core/widgets/custom_error_widget.dart';
import 'package:art_gallery/core/widgets/exhibition_item.dart';
import 'package:art_gallery/features/auth/domain/entites/user_entity.dart';
import 'package:art_gallery/features/auth/domain/repos/auth_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ExhibitionsGridView extends StatelessWidget {
  const ExhibitionsGridView(
      {super.key, required this.exhibitions, required this.filter});
  final List<ExhibitionEntity> exhibitions;
  final String filter;
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
        itemCount: exhibitions.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, // One item per row
          crossAxisSpacing: 16, // Horizontal spacing between cards
          mainAxisSpacing: 16, // Vertical spacing between cards
          childAspectRatio: 2.0,
        ),
        itemBuilder: (context, index) {
          return ExhibitionItem(
            exhibitionEntity: exhibitions[index],
            filter: filter,
          );
        });
  }
}
