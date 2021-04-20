import 'package:artblock/nav.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _ColorPageState extends State<ColorPage> {
  Color _customColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          AppBar(
            title: Text(
              'ArtBlock',
              style: GoogleFonts.poppins(fontSize: 20),
            ),
            elevation: 4.0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_sharp),
                onPressed: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Nav()))
                    }),
            actions: [IconButton(icon: Icon(Icons.check), onPressed: () => {})],
          ),
          SizedBox(height: 15),
          Container(
            width: 350,
            height: 100,
            child: Center(
              child: Text(
                'My current color is: ',
                style: GoogleFonts.poppins(fontSize: 15),
              ),
            ),
            color: _customColor,
          ),
          Card(
              elevation: 4.0,
              margin: EdgeInsets.all(30.0),
              child: new ColorPicker(
                color: Colors.blue,
                onChanged: (value) {
                  setState(() {
                    _customColor = value;
                  });
                },
              ))
        ],
      ),
    );
  }
}

class ColorPage extends StatefulWidget {
  @override
  _ColorPageState createState() => _ColorPageState();
}
