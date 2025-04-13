import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/categories_chip.dart';

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
List<String> typeItems = [
  'Sculpture',
  'Drawings',
  'Paintings',
  'Black and White',
  'Mosaic'
];

class ArtworkFiltersDialog extends StatefulWidget {
  ArtworkFiltersDialog(
      {super.key,
      required this.sortBy,
      required this.epoch,
      required this.type,
      required this.artist,
      required this.yearRange,
      required this.onApplyFilter,
      required this.forSale});

  String epoch = '';
  String type = '';
  String artist = '';
  String sortBy = 'Name A -> Z';
  RangeValues yearRange = const RangeValues(500, 2025);
  bool? forSale = null;
  String status = '';
  final Function(String sortBy, String epoch, String type, String artist,
      RangeValues yearRange, bool? forSale, String status) onApplyFilter;

  @override
  State<ArtworkFiltersDialog> createState() => _ArtworkFiltersDialogState(
      sortBy: sortBy,
      epoch: epoch,
      type: type,
      artist: artist,
      yearRange: yearRange,
      forSale: forSale,
      status: status);
}

class _ArtworkFiltersDialogState extends State<ArtworkFiltersDialog> {
  String sortBy = 'Name A -> Z';
  String epoch = '';
  RangeValues yearRange = const RangeValues(500, 2025);
  String type = '';
  String artist = '';
  bool? forSale = null;
  String status = '';
  _ArtworkFiltersDialogState({
    required this.sortBy,
    required this.epoch,
    required this.type,
    required this.artist,
    required this.yearRange,
    required this.forSale,
    required this.status,
  });

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
            _forSale(),
            _statusSelector(),
            _yearRange(),
            _typesSelector(),
            _artistsSelector(),
            _epochesSelector(),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                  onPressed: () {
                    widget.onApplyFilter(sortBy, epoch, type, artist, yearRange,
                        forSale, status);
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
                epoch = '';
                type = '';
                artist = '';
                yearRange = const RangeValues(500, 2025);
                forSale = null;
                status = '';
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
            value: sortBy == '' ? 'Name A -> Z' : sortBy,
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

  Widget _forSale() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'For Sale',
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
              children: [
                CategoriesChip(
                  label: "True",
                  isActive: forSale != null && forSale == true,
                  onPressed: () {
                    setState(() {
                      forSale = true;
                    });
                  },
                ),
                CategoriesChip(
                  label: "False",
                  isActive: forSale != null && forSale == false,
                  onPressed: () {
                    setState(() {
                      forSale = false;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusSelector() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Status',
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
              children: [
                CategoriesChip(
                  label: "Permenant",
                  isActive: status == 'Permenant',
                  onPressed: () {
                    setState(() {
                      status = 'Permenant';
                    });
                  },
                ),
                CategoriesChip(
                  label: "Borrowed",
                  isActive: status == 'Borrowed',
                  onPressed: () {
                    setState(() {
                      status = 'Borrowed';
                    });
                  },
                ),
              ],
            ),
          ),
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
              'Epoches',
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

  Widget _typesSelector() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Types',
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
                typeItems.length,
                (int index) {
                  return CategoriesChip(
                    label: typeItems[index],
                    isActive: type == typeItems[index],
                    onPressed: () {
                      setState(() {
                        type = typeItems[index];
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

  Widget _artistsSelector() {
    var artistList =
        FirebaseFirestore.instance.collection('artists').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: artistList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var artistsList =
              snapshot.data!.docs.map((e) => e['name'].toString()).toList();
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Artists',
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
                      artistsList.length,
                      (int index) {
                        return CategoriesChip(
                          label: artistsList[index],
                          isActive: artist == artistsList[index],
                          onPressed: () {
                            setState(() {
                              artist = artistsList[index];
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
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _yearRange() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Year Range',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
          ),
          RangeSlider(
            max: 2025,
            min: 500,
            labels: RangeLabels(
              yearRange.start.round().toString(),
              yearRange.end.round().toString(),
            ),
            onChanged: (RangeValues values) {
              setState(() {
                yearRange = values;
              });
            },
            activeColor: AppColors.primaryColor,
            inactiveColor: AppColors.gray,
            values: yearRange,
            divisions: 105,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('500'),
                Text('1000'),
                Text('1500'),
                Text('2025'),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _RatingStar extends StatelessWidget {
  const _RatingStar({
    required this.totalStarsSelected,
    required this.onStarSelect,
  });

  final int totalStarsSelected;
  final void Function(int) onStarSelect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Rating Star',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(
              /// You cannot add more than 5 star or less than 0 star
              5,
              (index) {
                if (index < totalStarsSelected) {
                  return InkWell(
                    onTap: () => onStarSelect(index + 1),
                    child: const Icon(
                      Icons.star_rounded,
                      color: Color(0xFFFFC107),
                      size: 32,
                    ),
                  );
                } else {
                  return InkWell(
                    onTap: () => onStarSelect(index + 1),
                    child: const Icon(
                      Icons.star_rounded,
                      color: Colors.grey,
                      size: 32,
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class _BrandSelector extends StatelessWidget {
  const _BrandSelector();

  @override
  Widget build(BuildContext context) {
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
              children: [
                CategoriesChip(
                  isActive: true,
                  label: 'Any',
                  onPressed: () {},
                ),
                CategoriesChip(
                  isActive: false,
                  label: 'Square',
                  onPressed: () {},
                ),
                CategoriesChip(
                  isActive: false,
                  label: 'Beximco Pharma',
                  onPressed: () {},
                ),
                CategoriesChip(
                  isActive: false,
                  label: 'ACI Limited',
                  onPressed: () {},
                ),
                CategoriesChip(
                  isActive: false,
                  label: 'See All',
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CategoriesSelector extends StatelessWidget {
  const _CategoriesSelector();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Categories',
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
              runAlignment: WrapAlignment.spaceAround,
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 16,
              runSpacing: 16,
              children: [
                CategoriesChip(
                  isActive: true,
                  label: 'Office Supplies',
                  onPressed: () {},
                ),
                CategoriesChip(
                  isActive: false,
                  label: 'Gardening',
                  onPressed: () {},
                ),
                CategoriesChip(
                  isActive: false,
                  label: 'Vegetables',
                  onPressed: () {},
                ),
                CategoriesChip(
                  isActive: false,
                  label: 'Fish And Meat',
                  onPressed: () {},
                ),
                CategoriesChip(
                  isActive: false,
                  label: 'See All',
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
