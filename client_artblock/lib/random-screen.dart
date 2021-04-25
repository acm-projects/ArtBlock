import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

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

  /*
  // Make own function?
  void onSwipedRight() {
    debugPrint("Swiped right");
  }
  */

  List<Card> cards = [
    Card(
      color: data[0]['color'],
      onSwipedRight: () {
        debugPrint("Swiped right");
      },
    ),
    Card(
      color: data[1]['color'],
      onSwipedRight: () {
        debugPrint("Swiped right");
      },
    ),
    Card(
      color: data[2]['color'],
      onSwipedRight: () {
        debugPrint("Swiped right");
      },
    ),
    Card(
      color: data[3]['color'],
      onSwipedRight: () {
        debugPrint("Swiped right");
      },
    ),
    Card(
      color: data[4]['color'],
      onSwipedRight: () {
        debugPrint("Swiped right");
      },
    ),
    Card(
      color: data[5]['color'],
      onSwipedRight: () {
        debugPrint("Swiped right");
      },
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
          cards.asMap().forEach((index, element) => element.url = urls[index]);
          return Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.7,
            child: Stack(
              children: cards,
            ),
          );
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
    data.forEach((element) => urls.add(element['url']));
    return urls;
  }

  Future<List<dynamic>> getData() async {
    var response = await http.get('http://127.0.0.1:8000/curated');
    //debugPrint(jsonDecode(response.body)[0]['url']);
    return jsonDecode(response.body);
  }
}

// swipable widget
class Card extends StatelessWidget {
  final Color color;
  final VoidCallback onSwipedRight; // maybe shouldn't use VoidCallback?
  var url;
  Card({@required this.color, this.onSwipedRight});

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
          image: DecorationImage(image: NetworkImage(url)),
        ),
      ),
      onSwipeRight: (Offset finalPosition) => onSwipedRight(),
    );
  }
}
