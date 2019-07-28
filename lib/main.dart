import 'about.dart';
import 'history.dart';
import 'package:flutter/material.dart';

enum LeaveBehindDemoAction { reset, horizontalSwipe, leftSwipe, rightSwipe }
enum MainMenuOptions { about, history }

class Choice {
  const Choice({this.title, this.icon, this.route});

  final String title;
  final IconData icon;
  final MainMenuOptions route;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'History', route: MainMenuOptions.history),
  const Choice(title: 'About', route: MainMenuOptions.about),
];

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Food',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MainPage(title: 'Home'),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String name = "";
  String desc = "";
  int _counter = 0;

  void onMenuSelected(MainMenuOptions value) {
    switch (value) {
      case MainMenuOptions.about:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AboutScreen()));
        break;
      case MainMenuOptions.history:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HistoryScreen()));
        break;
      default: // Without this, you see a WARNING.
        print('Default');
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepOrange,
        actions: <Widget>[
          new PopupMenuButton(
              onSelected: onMenuSelected,
              itemBuilder: (BuildContext context) {
                return choices.map((Choice choice) {
                  return new PopupMenuItem<MainMenuOptions>(
                    child: new Text(choice.title),
                    value: choice.route,
                  );
                }).toList();
              })
        ],
      ),
      body:
          new Container(
              padding: new EdgeInsets.all(20.0),
              child: new Form(
                key: formKey,
                autovalidate: true,
                child: new ListView(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: new TextFormField(
                          //controller: heightController,
                          keyboardType: TextInputType.text,
                          onSaved: (val) => this.name = val,
                          decoration: new InputDecoration(labelText: 'Name'),
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: new TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (val) => this.name = val,
                          decoration: new InputDecoration(labelText: 'Desc'),
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: new TextFormField(
                          keyboardType: TextInputType.number,
                          onSaved: (val) => this.name = val,
                          decoration: new InputDecoration(labelText: 'Count'),
                        )),
                    new Container(
                      width: screenSize.width,
                      child: new RaisedButton(
                          child: new Text('Order',
                              style: new TextStyle(color: Colors.white)),
                          color: Colors.deepOrange,
                          onPressed: () {
                            return showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: new Text("Order Summary"),
                                  content: Text('dss'),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: new Text("Close"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    new FlatButton(
                                      child: new Text("Confirm"),
                                      onPressed: () {
                                        return null;
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }),
                      margin: new EdgeInsets.only(top: 20.0),
                    )
                  ],
                ),
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Add Order',
        child: Icon(Icons.add),
      ),
    );
  }
}
