import 'package:flutter/foundation.dart';

class Album {
  final String image;
  final String title;
  final String subTitle;
  final String profile;
  final String author;
  final int comments;
  final bool showHome;

  Album(
      {@required this.image,
      @required this.title,
      @required this.subTitle,
      @required this.profile,
      @required this.author,
      @required this.comments,
      @required this.showHome});
}

final List<Album> albums = <Album>[
  Album(
      author: "Gordon",
      comments: 5,
      image: 'assets/images/d.jpg',
      profile: 'assets/images/b.jpg',
      showHome: true,
      subTitle: 'this is a card',
      title: 'Card'),
  Album(
      author: "John Doe",
      comments: 35,
      image: 'assets/images/e.jpeg',
      profile: 'assets/images/e.jpeg',
      showHome: false,
      subTitle: 'Leopard by John Doe',
      title: 'Park wild'),
  Album(
      author: "Mary berry",
      comments: 15,
      image: 'assets/images/f.jpeg',
      profile: 'assets/images/c.jpeg',
      showHome: false,
      subTitle: 'Cat club',
      title: 'Join cat club')
];
