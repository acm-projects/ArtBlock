import 'package:flutter/material.dart';
import 'package:client_artblock/nav.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ArtBlock',
      home: Nav(),
    );
  }
}
