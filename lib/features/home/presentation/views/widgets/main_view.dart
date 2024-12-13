import 'package:flutter/material.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/home_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});
  static const routeName = 'main_view';

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomeView(),
    Text('Page 2'),
    Text('Page 3'),
    Text('Page 4'),
  ];

  //New
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        onItemTapped: (int value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
      body: SafeArea(child: _pages.elementAt(_selectedIndex)),
    );
  }
}
