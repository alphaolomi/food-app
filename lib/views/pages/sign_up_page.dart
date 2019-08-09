import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();

  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController =
      TextEditingController();
  TextEditingController _confirmPasswordTextEditingController =
      TextEditingController();

  final _signupkey = GlobalKey<FormState>();
  final _passwordkey = GlobalKey<FormFieldState>();
  final _confirmpasswordkey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          key: _signupkey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100.0,
              ),
              Center(
                  child: Text("TeamUp",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 35))),
              SizedBox(
                height: 10.0,
              ),
              Center(
                  child: Text("Please fill in all details",
                      style: TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 12))),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 40, right: 40, bottom: 10, left: 40),
                child: TextFormField(
                  focusNode: _emailFocusNode,
                  controller: _emailTextEditingController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Email required';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: "Example@gmail.com",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, right: 40, bottom: 10, left: 40),
                child: TextFormField(
                    key: _passwordkey,
                    focusNode: _passwordFocusNode,
                    controller: _passwordTextEditingController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Password required';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, right: 40, bottom: 10, left: 40),
                child: TextFormField(
                    key: _confirmpasswordkey,
                    focusNode: _confirmPasswordFocusNode,
                    controller: _confirmPasswordTextEditingController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Password Required';
                      } else if (_confirmpasswordkey.currentState.value !=
                          _passwordkey.currentState.value) {
                        return 'Password do not match';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Confirm Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ))),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 30, right: 40, bottom: 10, left: 40),
                      child: RaisedButton(
                        padding: const EdgeInsets.all(17),
                        color: Colors.deepPurple,
                        onPressed: () {
                          if (_signupkey.currentState.validate()) {
                            print('good to go');
                          } else {
                            print('error');
                          }
                        },
                        child: Text("SIGN UP",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 25,
                                color: Colors.white)),
                        shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
