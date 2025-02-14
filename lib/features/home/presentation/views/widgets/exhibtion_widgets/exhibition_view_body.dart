import 'package:art_gallery/core/artwork_cubit/artworks_cubit.dart';
import 'package:art_gallery/core/exhibition_cubit/exhibitions_cubit.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/exhibtion_widgets/exhibitions_grid_view_bloc_builder.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/exhibtion_widgets/exhibitions_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExhibitionsViewBody extends StatefulWidget {
  const ExhibitionsViewBody({super.key});

  @override
  State<ExhibitionsViewBody> createState() => _ExhibitionsViewBodyState();
}

class _ExhibitionsViewBodyState extends State<ExhibitionsViewBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    _fetchExhibitions();
    _tabController.addListener(_fetchExhibitions);
  }

  void _fetchExhibitions() {
    final cubit = context.read<ExhibitionCubit>();
    switch (_tabController.index) {
      case 0:
        cubit.getExhibitions(filter: 'past');
        break;
      case 1:
        cubit.getExhibitions(filter: 'current');
        break;
      case 2:
        cubit.getExhibitions(filter: 'upcoming');
        break;
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_fetchExhibitions);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Exhibitions'),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              padding: const EdgeInsets.only(right: 20),
              iconSize: 30,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ExhibitionsSearchPage(),
                ));
              },
              icon: const Icon(Icons.search),
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            tabs: const [
              Tab(text: 'Past'),
              Tab(text: 'Current'),
              Tab(text: 'Upcoming'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildTabContent('past'),
            _buildTabContent('current'),
            _buildTabContent('upcoming'),
          ],
        ),
        // SliverToBoxAdapter(
        //   child: SizedBox(
        //     height: MediaQuery.of(context).size.height,
        //     child: TabBarView(
        //       controller: _tabController,
        //       children: [
        //         ExhibitionsGridViewBlocBuilder(),
        //         ExhibitionsGridViewBlocBuilder(),
        //         ExhibitionsGridViewBlocBuilder(),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }

  Widget _buildTabContent(String filter) {
    return CustomScrollView(
      slivers: [
        ExhibitionsGridViewBlocBuilder(filter: filter),
      ],
    );
  }
}
