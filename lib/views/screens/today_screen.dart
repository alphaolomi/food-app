import 'package:FoodApp/model/album.dart';
import 'package:FoodApp/views/componets/cards/album_card.dart';
import 'package:FoodApp/views/componets/header/simple_header.dart';
import 'package:flutter/material.dart';

class TodayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
            delegate: SliverChildListDelegate([
          SimpleHeader(
            date: 'Wed, 20, August, 2019',
            day: 'Today',
            padding: 10,
          ),
        ])),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return AlbumCard(
                album: albums[index],
                showDetails: true,
                padding: 10,
              );
            },
            childCount: albums.length,
          ),
        ),
      ],
    );
  }
}
