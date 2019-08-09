import 'package:flutter/material.dart';
import 'package:FoodApp/views/screens/category_screen.dart';
import 'package:FoodApp/views/screens/discover_screen.dart';
import 'package:FoodApp/views/screens/pages_screen.dart';
import 'package:FoodApp/views/screens/search_screen.dart';
import 'package:FoodApp/views/screens/today_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // iteration variable
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> screenWidgets = <Widget>[
      TodayScreen(),
      CategoryScreen(),
      DiscoverScreen(),
      SearchScreen(),
      PagesScreen()
    ];

    return Scaffold(
        body: DefaultTabController(
          child: screenWidgets.elementAt(_selectedIndex),
          length: 5,
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectIndex,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey[600],
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.today),
              title: Text(
                'Today',
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              title: Text(
                'Categories',
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              title: Text(
                'Discover',
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text(
                'Search',
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pages),
              title: Text(
                'Pages',
              ),
            )
          ],
        ));
  }

  void _selectIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
