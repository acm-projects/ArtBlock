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
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shuffle,
              ),
              label: 'random'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.push_pin), label: 'pins'),
        ],
        currentIndex: _selectedScreen,
        onTap: _onItemTap,
      ),
    );
  }
}
