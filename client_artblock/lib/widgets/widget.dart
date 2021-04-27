import 'dart:js';

import 'package:artblock/model/photos_model.dart';
import 'package:artblock/views/imageView.dart';
import 'package:flutter/material.dart';

Widget BrandName() {
  return RichText(
      text: TextSpan(
          text: '',
          style: TextStyle(fontSize: 20),
          children: <TextSpan>[
        TextSpan(
            text: 'Art',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    TextSpan(
        text: 'Block',
        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFCC66C2))),
        
      ]));
}

Widget photosList({List<PhotosModel> photos, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: .6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: photos.map((photo) {
        return GridTile(
            child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ImageView(
                          imgUrl: photo.src.portrait,
                        )));
          },
          child: Hero(
            tag: photo.src.portrait,
            child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      photo.src.portrait,
                      fit: BoxFit.cover,
                    ))),
          ),
        ));
      }).toList(),
    ),
  );
}
