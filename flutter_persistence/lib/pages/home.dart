import 'package:flutter/material.dart';
import 'package:flutter_persistence/pages/dogs/search.dart';
import 'package:flutter_persistence/pages/path/read-write-files.dart';
import 'package:flutter_persistence/pages/settings/settings.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/";
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _icon(String pageTitle, IconData _iconData, Widget pageWidget,
          String routeName, BuildContext context, String _title) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Colors.cyan[100],
            child: IconButton(
              color: Colors.blue[600],
              hoverColor: Colors.blue[100],
              padding: EdgeInsets.all(50),
              icon: Icon(
                _iconData,
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  routeName,
                );
              },
            ),
          ),
          Text(_title),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(
                context,
                SettingsPage.routeName,
              );
            },
          ),
        ],
      ),
      //drawer: MenuItems(),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _icon("Dogs", Icons.pets, DogsSearchPage(),
                DogsSearchPage.routeName, context, "Dogs (database)"),
            SizedBox(
              height: 20,
              width: 20,
            ),
            _icon(
              "Files",
              Icons.format_list_numbered,
              ReadWriteFilePage(
                storage: CounterStorage(),
              ),
              ReadWriteFilePage.routeName,
              context,
              "Counter (files)",
            ),
          ],
        ),
      ),
    );
  }
}
