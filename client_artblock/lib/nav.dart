import 'package:flutter/material.dart';
import 'package:artblock/home-screen.dart';
import 'package:artblock/pins-screen.dart';
import 'package:artblock/random-screen.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedScreen = 1;

  List<Widget> _widgetOptions = [RandomPage(), Home(), Pins()];

  void _onItemTap(int index) {
    setState(() {
      _selectedScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedScreen),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(color: Color(0xffCC66C2)),
        backgroundColor:  Color(0xff474E67),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.star,),
              label: 'Trending'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home,),
              label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.push_pin),
            label: 'Pins'
          )
        ],
        selectedItemColor: Color(0xffCC66C2),
        currentIndex: _selectedScreen,
        onTap: _onItemTap,
      ),
    );
  }
}
