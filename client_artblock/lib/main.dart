import 'package:flutter/material.dart';
import 'package:artblock/nav.dart';
import 'package:artblock/camera.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

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
