import 'package:flutter/foundation.dart';

class Food {
  final String image;
  final String title;
  final String subTitle;
  final String thumbnail;
  final String author;
  final int comments;
  final int rating;
  final bool showHome;

  Food({
    @required this.image,
    @required this.title,
    @required this.subTitle,
    @required this.thumbnail,
    @required this.author,
    @required this.comments,
    @required this.rating,
    @required this.showHome,
  });
}

final List<Food> foods = <Food>[
  Food(
    title: 'Chicken Burger',
    comments: 5,
    rating: 4,
    image: 'assets/images/a.jpg',
    thumbnail: 'assets/images/foods/b.jpeg',
    showHome: true,
    subTitle: 'Mzigo mzitoo balaaa',
    author: "By Shafii",
  ),
  Food(
    title: 'Burger Masala',
    comments: 35,
    rating: 4,
    image: 'assets/images/foods/a.jpeg',
    thumbnail: 'assets/images/e.jpeg',
    showHome: false,
    subTitle: 'Best burger in Tanzania',
    author: "By Veda",
  ),
];
