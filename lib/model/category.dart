import 'package:flutter/material.dart';

class Category {
  final String name;
  final String icon;
  final Color color;

  Category({@required this.name, @required this.icon, @required this.color});
}

List<Category> categories = <Category>[
  Category(
      color: Colors.orange,
      icon: 'assets/images/categories/football.png',
      name: 'Sports'),
  Category(
      color: Colors.cyan[200],
      icon: 'assets/images/categories/travel.png',
      name: 'Travel'),
  Category(
      color: Colors.pink,
      icon: 'assets/images/categories/radio.png',
      name: 'Music'),
  Category(
      color: Colors.blue,
      icon: 'assets/images/categories/puzzle.png',
      name: 'Gaming'),
  Category(
      color: Colors.green,
      icon: 'assets/images/categories/church.png',
      name: 'Church'),
  Category(
      color: Colors.pinkAccent,
      icon: 'assets/images/categories/mosque.png',
      name: 'Mosque'),
  Category(
      color: Colors.teal,
      icon: 'assets/images/categories/camera.png',
      name: 'Photo'),
  Category(
      color: Colors.pink[50],
      icon: 'assets/images/categories/groceries.png',
      name: 'Food')
];
