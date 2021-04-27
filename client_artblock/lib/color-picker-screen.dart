import 'package:artblock/nav.dart';
import 'package:artblock/search_view.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _ColorPageState extends State<ColorPage> {
  Color _customColor = Colors.blue;
  String search;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff373D54),
      body: Column(
        children: <Widget>[
          AppBar(
            toolbarHeight: 70,
            backgroundColor: Color(0xFF474E67),
          title: RichText(
          text: TextSpan(
            style: TextStyle(
              // global text style
              fontSize: 20,
            ),
            children: <TextSpan>[
              TextSpan(
                  text: 'Image',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              TextSpan(
                  text: 'Select',
                  style: TextStyle(
                      color: Color(0xFFCC66C2), fontWeight: FontWeight.bold)),
            ],
              )
            ),
            elevation: 4.0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
                onPressed: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Nav()))
                    }),
            actions: [
              IconButton(
                  icon: Icon(Icons.check, color: Colors.white),
                  onPressed: () => {
                    search = _customColor.value.toRadixString(16),
                    search = search.substring(2, search.length),
                    print(_customColor.value.toRadixString(16)),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                          
                                builder: (context) => SearchView(
                                    searchQuery: "art&color=%23" +
                                        search)))
                      })
            ],
          ),
          SizedBox(height: 100),
          Card(
            margin: EdgeInsets.fromLTRB(15, 50, 15, 50),
            child: new ColorPicker(
                  
                  color: Colors.blue,
                  onChanged: (value) {
                    setState(() {
                      _customColor = value;
                    });
                  },
                ),
          )
        ],
      ),
    );
  }
}

class ColorPage extends StatefulWidget {
  @override
  _ColorPageState createState() => _ColorPageState();
}
