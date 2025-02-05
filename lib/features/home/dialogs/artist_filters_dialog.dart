import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../components/categories_chip.dart';

class ArtistFiltersDialog extends StatefulWidget {
  const ArtistFiltersDialog(
      {super.key,
      required this.onApplyFilter,
      required this.sortBy,
      required this.epoch});
  final Function(String sortBy, String epoch) onApplyFilter;
  final String sortBy;
  final String epoch;
  @override
  State<ArtistFiltersDialog> createState() =>
      _ArtistFiltersDialogState(sortBy: sortBy, epoch: epoch);
}

class _ArtistFiltersDialogState extends State<ArtistFiltersDialog> {
  _ArtistFiltersDialogState({required this.epoch, required this.sortBy});
  String sortBy;
  String epoch;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.all(8),
            ),
            _filterHeader(),
            _sortBy(),
            _epochesSelector(),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                  onPressed: () {
                    widget.onApplyFilter(sortBy, epoch);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Apply Filter'),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _filterHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 56,
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: 40,
            width: 40,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: AppColors.scaffoldWithBoxBackground,
              ),
              child: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Text(
          'Filter',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
        ),
        SizedBox(
          width: 56,
          child: TextButton(
            onPressed: () {
              setState(() {
                sortBy = 'Name A -> Z';
                epoch = "";
              });
            },
            child: Text(
              'Reset',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.black, fontSize: 12),
            ),
          ),
        )
      ],
    );
  }

  Widget _sortBy() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Text(
            'Sort By',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
          const Spacer(),
          DropdownButton(
            value: sortBy,
            underline: const SizedBox(),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: AppColors.primaryColor,
            ),
            items: const [
              DropdownMenuItem(
                value: 'Name A -> Z',
                child: Text('Name A -> Z'),
              ),
              DropdownMenuItem(
                value: 'Name Z -> A',
                child: Text('Name Z -> A'),
              ),
              DropdownMenuItem(
                value: 'Oldest to Newest',
                child: Text('Oldest to Newest'),
              ),
              DropdownMenuItem(
                value: 'Newest to Oldest',
                child: Text('Newest to Oldest'),
              ),
            ],
            onChanged: (v) {
              setState(() {
                sortBy = v as String;
              });
            },
          )
        ],
      ),
    );
  }

  Widget _epochesSelector() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Brand',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 16,
              runSpacing: 16,
              children: List<Widget>.generate(
                epochItems.length,
                (int index) {
                  return CategoriesChip(
                    label: epochItems[index],
                    isActive: epoch == epochItems[index],
                    onPressed: () {
                      setState(() {
                        epoch = epochItems[index];
                      });
                    },
                  );
                },
              ).toList(),
            ),
          )
        ],
      ),
    );
  }
}

final List<String> epochItems = [
  'Prehistoric Art',
  'Ancient Art',
  'Classical Art',
  'Byzantine Art',
  'Romanesque Art',
  'Renaissance Art',
  'Neoclassical Art',
  'Romanticism',
  'Impressionism',
  'Modernism',
  'Contemporary Art',
  'Realism',
  'Expressionism',
  'Ancient Roman Art',
  'Rococo Art',
  'Baroque Art'
];
