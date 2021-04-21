import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
    this.setState((){
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }
  // take a picture method
  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState((){
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }
  
  Future<void> _showChoiceDialog(BuildContext context){
    return showDialog(context: context,builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Choose An Option"),
        
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text("Gallery"),onTap: (){
                  _openGallery(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                child: Text("Camera"),onTap: (){
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
  Widget _deicdeImageView(){
    if(imageFile == null){
      return Text("No Image Selected");
    } else {
      Image.file(imageFile,width: 400,height: 400);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Camera Screen"),
        ),
       body: Container(
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _deicdeImageView();
            ElevatedButton(onPressed: (){
              _showChoiceDialog(context);
            },child: Text("Select Image"),)
          ],
        ),
        ),
       ),
    );
  }
}

