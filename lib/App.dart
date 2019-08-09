import 'package:flutter/material.dart';
import 'package:FoodApp/views/pages/home_page.dart';
import 'package:FoodApp/views/pages/login_page.dart';
import 'package:FoodApp/views/pages/login_screen.dart';
import 'package:FoodApp/views/pages/sign_up_page.dart';

import 'constant/constant.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepOrangeAccent
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        loginPage: (BuildContext context) => LoginPage(),
        signIn: (BuildContext context) => LoginScreen(),
        signUp: (BuildContext context) => SignUpPage(),
        homePage: (BuildContext context) => HomePage(),
      },
    );
  }
}
