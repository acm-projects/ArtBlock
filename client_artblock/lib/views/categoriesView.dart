import 'dart:convert';

import 'package:artblock/model/photos_model.dart';
import 'package:artblock/searchData/searchData.dart';
import 'package:artblock/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoriesView extends StatefulWidget {
  final String categorieName;
  CategoriesView({this.categorieName});

  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  List<PhotosModel> photos = new List();

  getCategoriePhotos(String query) async {
    var response = await http.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=30&page=1",
        headers: {"Authorization": apiKey});

    //print(response.body.toString());

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      //print(element);
      PhotosModel photosModel = new PhotosModel();
      photosModel = PhotosModel.fromMap(element);
      photos.add(photosModel);
    });

    setState(() {});
  }

  @override
  void initState() {
    getCategoriePhotos(widget.categorieName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF474E67),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        toolbarHeight: 70,
        title: BrandName(),
        elevation: 2.0,
        backgroundColor: Color(0xFF474E67)
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: 16,
            ),
            photosList(photos: photos, context: context)
          ],
        )),
      ),
    );
  }
}
