import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:FoodApp/model/album.dart';

class AlbumCard extends StatelessWidget {
  final Album album;
  final double padding; 

  final bool showDetails;
  const AlbumCard({Key key, @required this.album, @required this.showDetails,  @required this.padding}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(padding),
        height: 400,
        child: Stack(
          children: <Widget>[
            Container(
              height: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.transparent),
                  image: DecorationImage(
                      image: AssetImage(album.image),
                      fit: BoxFit.cover)),
            ),
            album.showHome
                ? Padding(
                    padding: const EdgeInsets.only(top: 10, right: 20),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: RaisedButton.icon(
                        color: Colors.pinkAccent,
                        shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        icon: Icon(
                          FontAwesomeIcons.fire,
                          color: Colors.white,
                        ),
                        label: Text(
                          'HOT',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  )
                : Container(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 110,
                  // color: Colors.green,
                  margin: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        album.title,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        album.subTitle,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                     showDetails? Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: AssetImage(album.profile),
                            radius: 20,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                album.author,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: Icon(
                                  Icons.comment,
                                  color: Colors.white,
                                )), 
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              album.comments.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ): Container()
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    
  }
}
