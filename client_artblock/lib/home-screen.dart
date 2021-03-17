import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  TextEditingController searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 250),
          RichText(
            text: TextSpan(
              style: TextStyle(
                // global text style
                fontSize: 45,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: 'Art',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                TextSpan(
                    text: 'Block',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          SizedBox(height: 30),
          Container(
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
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Ink(
                decoration: ShapeDecoration(
                  shape: CircleBorder(), // I want to add a border to the button
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.camera_alt_rounded),
                  color: Colors.black,
                ),
              ),
              Ink(
                decoration: ShapeDecoration(
                  shape: CircleBorder(), // I want to add a border to the button
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.pool_sharp),
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
