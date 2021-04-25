import 'package:artblock/search_view.dart';
import 'package:flutter/material.dart';
import 'package:artblock/nav.dart';
import 'package:artblock/camera.dart';
import 'package:artblock/new-camera-screen.dart';

import 'home-screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ArtBlock',
      theme: ThemeData(primaryColor: Colors.white),
      home: Home(),
    );
  }
}
