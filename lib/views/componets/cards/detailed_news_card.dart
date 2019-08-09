import 'package:flutter/material.dart';
import 'package:FoodApp/model/album.dart';

class DetailedNews extends StatelessWidget {
  final Album album;

  final double padding;
  const DetailedNews({Key key, @required this.album, @required this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              image: DecorationImage(
                  image: AssetImage(album.image), fit: BoxFit.cover),
            ),
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Text(
                        'GAMING',
                        style: TextStyle(color: Colors.grey[300], fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Text(
                        'Soprano Announces His New',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 27),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        'Mozilla has announced a new version of its browser for augmented reality',
                        style: TextStyle(color: Colors.grey[500], fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
