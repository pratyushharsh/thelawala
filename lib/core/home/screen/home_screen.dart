import 'package:flutter/material.dart';
import 'package:thelawala/constants/Constants.dart';
import 'package:thelawala/core/settings/settings.dart';
import 'package:thelawala/modules/category/category_screen.dart';
import 'package:thelawala/modules/dashboard/detail/dashboard-detail.dart';
import 'package:thelawala/modules/orders/order-search-screen.dart';
import 'package:thelawala/utils/services/menu-service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MenuRepository repo = MenuRepository();

  int _selectedIndex = 0;

  static List<Widget> _tabs = [
    DashboardDetail(),
    CategoryScreen(),
    OrderDetail(),
    Settings()
  ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE9EBEE),
      body: _tabs[_selectedIndex],
      bottomNavigationBar: Row(
        children: [
          buildNavbarItem(Icon(Icons.home), 0),
          buildNavbarItem(Icon(Icons.menu), 1),
          buildNavbarItem(Icon(Icons.bookmark_border), 2),
          buildNavbarItem(Icon(Icons.settings), 3),
        ],
      ),
    );
  }

  Widget buildNavbarItem(Widget icon, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Container(
            height: tAppBarToolbarHeight,
            decoration: _selectedIndex == index
                ? BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 4, color: Colors.white)),
                    gradient: LinearGradient(colors: [
                      Colors.white.withOpacity(0.5),
                      Colors.white.withOpacity(0.025)
                    ], begin: Alignment.bottomCenter, end: Alignment.topCenter))
                : BoxDecoration(),
            child: icon),
      ),
    );
  }
}
