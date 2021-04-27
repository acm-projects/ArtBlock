import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:palette_generator/palette_generator.dart';

/* add image_picker to dependencies under yaml */
void main() {
  runApp(new MaterialApp(
    title: "Camera",
    home: CameraScreen(),
  ));
}

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File imageFile;
  // upload from gallery method
  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    var fileName = basename(picture.path);
    debugPrint(fileName);
    File localImage = await picture.copy('$appDocPath/$fileName');
    this.setState(() {
      imageFile = localImage;
    });
    getData();

    Navigator.of(context).pop();
  }

  // take a picture method
  Future<void> _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    var fileName = basename(picture.path);
    debugPrint(fileName);
    File localImage = await picture.copy('$appDocPath/$fileName');
    this.setState(() {
      imageFile = localImage;
    });
    getData();

    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Choose An Option"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  // shows selected image or tells the user that no image is selected
  Widget _deicdeImageView() {
    if (imageFile == null) {
      return new Text('No Image Selected',
          style: TextStyle(
            //inbuilt named colors
            color: Colors.white,
          ));
    } else {
      return Image.file(imageFile, width: 400, height: 400);
    }
  }

  Future<List<dynamic>> getData() async {
    var paletteGenerator = await PaletteGenerator.fromImageProvider(
      Image.file(imageFile).image,
    );
    var domColor =
        paletteGenerator.dominantColor.color.toString().substring(8, 14);
    print(domColor);
    var response = await http.get('http://10.0.2.2:8000/color/hex/' + domColor);
    //var response = await http.get('http://10.0.2.2:8000/query/frog');
    //print(response.statusCode);
    //debugPrint(response.body);
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        toolbarHeight: 70,
        backgroundColor: Color(0xFF474E67) ,
        title: BrandName(),
        elevation: 2.0,
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
          ),
        ),
      ),
      body: Container(
        color: Color(0xFF373D54),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _deicdeImageView(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0xFFCC66C2)),
                  onPressed: () {
                    _showChoiceDialog(context);
                  },
                  child: new Text(
                    'SELECT',
                    style: TextStyle(
                      //inbuilt named colors
                      color: Colors.white,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
