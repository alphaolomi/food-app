import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      // margin: EdgeInsets.all(50),
      height: MediaQuery.of(context).size.height / 9,
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/images/a.jpg'),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 30, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[Text('Jess Roxana'), Text('Journalist')],
              ),
            ),
          ),
          Expanded(
            child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.star, color: Colors.yellow)),
          ),
        ],
      ),
    );
  }
}
