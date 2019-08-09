import 'package:flutter/material.dart';
import 'package:FoodApp/model/album.dart';

class ImageText extends StatelessWidget {
  final Album album;
  // final double padding;

  const ImageText({Key key, @required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      // padding: EdgeInsets.only(left: padding, right: padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          // color: Colors.pink,
        ),
        height: height / 3,
        width: width,
        child: Stack(
          children: <Widget>[
            Container(
              height: height / 3,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: AssetImage(album.image),
                    fit: BoxFit.cover),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(15),
                height: height / 12,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  color: Colors.black26,
                ),

                child: Text(album.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ));
  }
}
