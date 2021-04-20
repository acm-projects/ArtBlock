import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
    getCardData();
  }

  List<Card> cards = [
    Card(
      data[0]['color'],
    ),
    Card(
      data[1]['color'],
    ),
    Card(
      data[2]['color'],
    ),
    Card(
      data[3]['color'],
    ),
    Card(
      data[4]['color'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Stack(
        children: cards,
      ),
    );
  }

  void getCardData() async {
    var data = await getData();
    data.forEach((element) => debugPrint("The data is ${element['url']}"));
  }

  Future<List<dynamic>> getData() async {
    var response = await http.get('http://127.0.0.1:8000/query/art');
    //debugPrint(jsonDecode(response.body)[0]['url']);
    return jsonDecode(response.body);
  }
}

class Card extends StatelessWidget {
  final Color color;
  Card(this.color);

  @override
  Widget build(BuildContext context) {
    return Swipable(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0), color: color),
      ),
    );
  }
}
