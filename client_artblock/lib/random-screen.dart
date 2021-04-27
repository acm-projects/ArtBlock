import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:artblock/main.dart';
import 'package:artblock/searchData/searchData.dart';

import 'model/photos_model.dart';

// Database
final List data = [
  {'color': Colors.red},
  {'color': Colors.blue},
  {'color': Colors.green},
  {'color': Colors.yellow},
  {'color': Colors.pink},
  {'color': Colors.black},
];

class RandomPage extends StatefulWidget {
  @override
  _RandomPageState createState() => _RandomPageState();
}

//images gotten from the data base
class _RandomPageState extends State<RandomPage> {
  @override
  void initState() {
    super.initState();
  }

  List<Card> cards = [
    Card(
      color: data[0]['color'],
    ),
    Card(
      color: data[1]['color'],
    ),
    Card(
      color: data[2]['color'],
    ),
    Card(
      color: data[3]['color'],
    ),
    Card(
      color: data[4]['color'],
    ),
    Card(
      color: data[5]['color'],
    )
  ];

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
          cards.forEach((element) =>
              element.onSwipedRight = () => saveImage(element.url));
          cards.asMap().forEach((index, element) => element.url = urls[index]);
          return Scaffold(
              appBar: AppBar(
                title: Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          // global text style
                          fontSize: 20,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Trending ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: 'Center',
                              style: TextStyle(
                                  color: Color(0xFFCC65C2),
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )),
                backgroundColor: Color(0xFF474E67),
              ),
              backgroundColor: Color(0xFF373D54),
              body: Center(
                  child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Stack(
                  children: cards,
                ),
              )));
        }
        return Container();
      },
      future: getCardData(),
    );
  }

  Future<List<dynamic>> getCardData() async {
    List urls = [];
    var data = await getData();
    //data.forEach((element) => debugPrint("The data is ${element['url']}"));
    Map<String, dynamic> jsonData = data;
    data['photos'].forEach((element) {
      urls.add(element['src']['portrait']);
    });
    return urls;
  }

  Future<Map<String, dynamic>> getData() async {
    var response = await http.get("https://api.pexels.com/v1/curated?page=2",
        headers: {"Authorization": apiKey});
    //var response = await http.get('http://10.0.2.2:8000/curated');
    //debugPrint(jsonDecode(response.body)[0]['url']);
    return jsonDecode(response.body);
  }
}

// swipable widget
class Card extends StatelessWidget {
  final Color color;
  VoidCallback onSwipedRight; // maybe shouldn't use VoidCallback?
  var url;
  Card({@required this.color});

  @override
  Widget build(BuildContext context) {
    // Create the stream
    StreamController<double> _controller = StreamController<double>();

    // Trigger programmatically
    //_controller.add(1);

    return Swipable(
      swipe: _controller.stream, // Pass the stream to the widget
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: color,
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
        ),
      ),
      onSwipeRight: (Offset finalPosition) => onSwipedRight(),
    );
  }
}
