import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  TextEditingController searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                      hintText: "Search",
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 14.0),
                      suffixIcon: Icon(Icons.search),
                      border: InputBorder.none),
                ))),
      ),
    );
  }
}
