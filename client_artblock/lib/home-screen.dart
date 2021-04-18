import 'package:artblock/color-picker-screen.dart';
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
                  shape: CircleBorder(),
                  shadows: [
                    BoxShadow(
                      color: Colors.grey[600],
                      offset: Offset(1.0, 1.0),
                      blurRadius: 1.5,
                      spreadRadius: 1.0,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-1.0, -1.0),
                      blurRadius: 1.5,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.camera_alt_rounded),
                  color: Colors.black,
                ),
              ),
              Ink(
                decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  shadows: [
                    BoxShadow(
                      color: Colors.grey[600],
                      offset: Offset(1.0, 1.0),
                      blurRadius: 1.0,
                      spreadRadius: .5,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-1.0, -1.0),
                      blurRadius: 1.0,
                      spreadRadius: .5,
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ColorPage()));
                  },
                  icon: Icon(Icons.color_lens),
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
