import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';

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
