import 'package:flutter/material.dart';
import 'package:FoodApp/constant/constant.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 250),
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.transparent,
                child: Image(
                  image: AssetImage('assets/icon/diamond.png'),
                  height: 150,
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Text("Food App",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 35,
                )),
            Text("The app tagline goes here",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15)),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.deepPurple,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              child: Text("LOG IN",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.pushNamed(context, signIn);
              },
            ),
            // CarouselSlider(items: <Widget>[],),
            FlatButton(
              child: Text("SIGN UP",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.pushNamed(context, signUp);
              },
            )
          ],
        ),
      ),
    );
  }
}
