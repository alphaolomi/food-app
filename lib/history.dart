import 'package:flutter/material.dart';
//import 'package:advanced_share/advanced_share.dart';

class HistoryScreen extends StatelessWidget {
  static const String _title = 'Food App';
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: _title,
      theme: new ThemeData(primarySwatch: Colors.deepOrange),
      home: HistoryPage(title: 'History'),
    );
  }
}

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HistoryPageState createState() => new _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DismissDirection _dismissDirection = DismissDirection.horizontal;
  Object get key => null;

  void generic() {
//    AdvancedShare.generic(
//      msg: "Shared from *Brandful Media* App \n100 * 200 * 22,000 = 44,000",
//      title: "Share",
//    ).then((response) {
//      print(response);
//    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Dismissible(
          key: new ObjectKey(key),
          direction: _dismissDirection,
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              // Delete function
            } else {
              generic();
            }
          },
          background: new Container(
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: const ListTile(
                    leading: const Icon(Icons.share,
                        color: Colors.white, size: 30.0)),
              )),
          secondaryBackground: new Container(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: const ListTile(
                    trailing: const Icon(Icons.delete,
                        color: Colors.white, size: 30.0)),
              )),
          child: new Container(
              decoration: new BoxDecoration(
                  color: theme.canvasColor,
                  border: new Border(
                      bottom: new BorderSide(color: theme.dividerColor))),
              child: new ListTile(
                  title: new Text('User Name'),
                  subtitle: new Text(
                      'Measurements description goes here\nMaterial Selected'),
                  isThreeLine: true))),
    );
  }
}
