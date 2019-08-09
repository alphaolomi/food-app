import 'package:flutter/material.dart';

class SimpleHeader extends StatelessWidget {
  final String date;
  final String day;
  final double padding;

  const SimpleHeader({Key key, @required this.date, @required this.day, @required this.padding})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: padding, right: padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Text(date),
          Text(day,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
