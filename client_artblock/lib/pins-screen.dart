import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Pins extends StatefulWidget {
  @override
  _PinsState createState() => _PinsState();
}

class _PinsState extends State<Pins> {
  @override
  void initState() {
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
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
                title: Text(
                  "MY PROFILE",
                  style: TextStyle(
                      color: Colors.redAccent, fontWeight: FontWeight.bold),
                ),
              ),
              body: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                    "John Doe",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "@johndoe",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Divider(height: 18.0, thickness: 0.6, color: Colors.black),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemCount: urls.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 2.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://cors-anywhere.herokuapp.com/' +
                                            urls[index]))),
                          );
                        }),
                  )),
                ],
              )));
        }
        return Container();
      },
      future: getImage(),
    );
  }

  Future<List<dynamic>> getImage() async {
    List urls = [];
    List data = await getData();
    data.forEach((element) => urls.add(element['url']));
    return urls;
  }

  Future<List<dynamic>> getData() async {
    var response = await http.get('http://127.0.0.1:8000/query/art');
    //debugPrint(jsonDecode(response.body)[0]['url']);
    return jsonDecode(response.body);
  }

  _read() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/my_file.txt');
      String text = await file.readAsString();
      print(text);
    } catch (e) {
      print("Couldn't read file");
    }
  }

  _save() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/my_file.txt');
    final text = 'Hello World!';
    await file.writeAsString(text);
    print('saved');
  }

}
