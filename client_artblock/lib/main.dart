import 'package:artblock/search_view.dart';
import 'package:flutter/material.dart';
import 'package:artblock/nav.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  runApp(MyApp());
  await buildImageList();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ArtBlock',
      theme: ThemeData(primaryColor: Colors.white),
      home: Nav(),
    );
  }
}

// ignore: missing_return
Future<List<String>> buildImageList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> photos = [];
  prefs.setStringList('images', photos);
  return photos;
}

Future<List<String>> retrieveImageList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('images');
}

Future<void> saveImage(String url) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List photos = prefs.getStringList('images');
  photos.add(url);
  prefs.setStringList('images', photos);
}
