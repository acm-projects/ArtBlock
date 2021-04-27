import 'dart:convert';
import 'dart:developer';

import 'package:artblock/new-camera-screen.dart';
import 'package:artblock/color-picker-screen.dart';
import 'package:artblock/search_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Home extends StatelessWidget {
  String query;

  TextEditingController searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF474E67),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 120),
          Image.asset('assets/graphics/artblock.png'),
          SizedBox(height: 20),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Card(
                  elevation: 3.0,
                  color: const Color(0xFFAFB9DE),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                        hintText: "Search",
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 14.0),
                        suffixIcon: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchView(
                                          searchQuery: searchController.text)));
                            },
                            child: Icon(Icons.search)),
                        border: InputBorder.none),
                  ))),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Ink(
                decoration: ShapeDecoration(
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CameraScreen()));
                  },
                  icon: Icon(Icons.camera_alt_rounded),
                  color: const Color(0xFFAFB9DE),
                ),
              ),
              Ink(
                decoration: ShapeDecoration(
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ColorPage()));
                  },
                  icon: Icon(Icons.color_lens),
                  color: const Color(0xFFAFB9DE),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
