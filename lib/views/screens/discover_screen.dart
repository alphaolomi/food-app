import 'package:flutter/material.dart';
import 'package:FoodApp/model/album.dart';
import 'package:FoodApp/views/componets/cards/image_text_card.dart';
import 'package:FoodApp/views/componets/header/simple_header.dart';

class DiscoverScreen extends StatelessWidget {
  final Album album;

  const DiscoverScreen({Key key, this.album}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            SimpleHeader(
              date: "18 may 2019",
              day: "Monday",
              padding: 20,
            ),
          ]),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: MediaQuery.of(context).size.height / 3,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ImageText(
                      album: albums[index],
                    ),
                  ),
                );
              },
              itemCount: albums.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
      ],
    );
  }
}
