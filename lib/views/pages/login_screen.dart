import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:FoodApp/constant/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // instantiate FocusNodes for input fields
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  // Text Editing controllers for getting user input data
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController =
      TextEditingController();

  // form controller key
  final _loginScreenKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final String _userEmail = "a@g.c";
  final String _userPassword = "1";

  bool _isObscure = true;

  _launchURL(_url) async {
    if (await canLaunch(_url)) {
      await launch(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.deepPurple,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _loginScreenKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100.0,
              ),
              Center(
                child: Text("TeamUP",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 35,
                    )),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Text("Please fill in all details",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                    )),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 40, top: 40, right: 40, bottom: 10),
                child: TextFormField(
                  key: _emailKey,
                  focusNode: _emailFocusNode,
                  controller: _emailTextEditingController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Email Required';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'example@gmail.com',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 40, top: 10, right: 40, bottom: 10),
                child: TextFormField(
                  key: _passwordKey,
                  focusNode: _passwordFocusNode,
                  controller: _passwordTextEditingController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Password Required';
                    }else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                          print(_isObscure);
                        },
                        icon: Icon(_isObscure
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash)),
                    hintText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                  ),
                ),
              ),
              FlatButton(
                child: Text(
                  'Forget you password?',
                  style: TextStyle(color: Colors.deepPurple),
                ),
                onPressed: () {},
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 40, top: 50, right: 40, bottom: 10),
                      child: RaisedButton(
                        padding: const EdgeInsets.all(17),
                        shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Colors.deepPurple,
                        child: Text('LOG IN',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 25,
                                color: Colors.white)),
                        onPressed: () {
                          if (_loginScreenKey.currentState.validate()) {
                            if (_userEmail ==
                                    _emailTextEditingController.text &&
                                _userPassword ==
                                    _passwordTextEditingController.text) {
                              Navigator.pushReplacementNamed(context, homePage);
                            } else {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: ListTile(
                                  leading: Icon(Icons.error),
                                  title: Text('incorrect email or password'),
                                  trailing: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                ),
                                backgroundColor: Colors.deepPurple,
                                duration: Duration(seconds: 1),
                              ));
                            }
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            const facebookUrl = "https://facebook.com";
                            _launchURL(facebookUrl);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            child: Icon(
                              FontAwesomeIcons.facebookF,
                              color: Colors.blue[900],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          const twitterUrl = "https://twitter.com";
                          _launchURL(twitterUrl);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 1, color: Colors.grey)),
                          child: Icon(
                            FontAwesomeIcons.twitter,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            const instaUrl = "https://instagram.com";
                            _launchURL(instaUrl);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            child: Icon(
                              FontAwesomeIcons.instagram,
                              color: Colors.pinkAccent,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
