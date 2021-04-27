import 'dart:convert';
import 'package:artblock/main.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pins extends StatefulWidget {
  @override
  _PinsState createState() => _PinsState();
}

class _PinsState extends State<Pins> {
  Future<List> gridImages;

  @override
  void initState() {
    gridImages = retrieveImageList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, apicall) {
        if (apicall.connectionState == ConnectionState.done) {
          if (apicall.hasError) {
            return Center(
              child: Text("No images present"),
            );
          }
        }
        if (apicall.hasData) {
          List urls = apicall.data;
          return Scaffold(

              backgroundColor: Color(0xff373D54),
              body: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 118,),
                  CircleAvatar(
                    radius: 56,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1517841905240-472988babdf9?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80'),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    "Jenna Lake",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "@jennaLake",
                    style: TextStyle(
                      color: Color(0xffCC66C2),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 3.0,
                          crossAxisSpacing: 3.0,
                          crossAxisCount: 3,
                        ),
                        itemCount: urls.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                urls[index]))),
                          );
                        }),
                  )),
                ],
              )));
        }
        return Container();
      },
      future: retrieveImageList(),
    );
  }

}
