import 'dart:convert';

import 'package:artblock/model/categories_model.dart';
import 'package:artblock/searchData/searchData.dart';
import 'package:artblock/views/categoriesView.dart';
import 'package:artblock/views/imageView.dart';
import 'package:artblock/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:http/http.dart' as http;

import 'model/photos_model.dart';

class SearchView extends StatefulWidget {
  final String searchQuery;
  SearchView({this.searchQuery});
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<CategorieModel> categories = new List();
  List<PhotosModel> photos = new List();
  TextEditingController searchController = new TextEditingController();
  //String query = 'nature';

  getTrendingPhotos(String query) async {
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
    getTrendingPhotos(widget.searchQuery);
    categories = getCategories();
    //searchController.text = widget.searchQuery;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff373D54),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        toolbarHeight: 70,
        backgroundColor: Color(0xFF474E67) ,
        title: BrandName(),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: <Widget>[
            SizedBox(height: 16,),
            Container(
              decoration: BoxDecoration(
                color: Color(0xfff58fd),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24),
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: Row(children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      getTrendingPhotos(searchController.text);
                    },
                    child: Container(child: Icon(Icons.search, color: Colors.white,)))
              ]),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: 80,
              child: ListView.builder(
                itemCount: categories.length,
                padding: EdgeInsets.symmetric(horizontal: 24),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CategoriesTile(
                    title: categories[index].categorieName,
                    imgUrl: categories[index].imgUrl,
                  );
                },
              ),
            ),
            photosList(photos: photos, context: context)
          ],
        )),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String imgUrl, title;
  CategoriesTile({@required this.title, @required this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoriesView(
                      categorieName: title.toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 4),
        child: Stack(
          children: <Widget>[
            GestureDetector(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(imgUrl,
                      height: 50, width: 100, fit: BoxFit.cover)),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              height: 50,
              width: 100,
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
