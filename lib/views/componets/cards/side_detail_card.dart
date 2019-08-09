import 'package:flutter/material.dart';
import 'package:FoodApp/model/album.dart';

class SideDetail extends StatelessWidget {
  final Album album;

  const SideDetail({Key key, @required this.album}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(left: 20, top: 50),
      height: height / 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              height: height / 4,
              width: width * 2 / 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage(album.image),
                      fit: BoxFit.cover)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    album.title,
                    style: TextStyle(color: Colors.grey[600], fontSize: 20,),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Mozilla has announced a new version of its browser for',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    // maxLines: 3,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: AssetImage(album.profile),
                        radius: 15,
                      ),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                        album.author,
                        style: TextStyle(fontSize: 20),
                        maxLines: 1,
                      ),
                          )),
                    ],
                  ),
                  
                  Divider(
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
