import 'package:flutter/material.dart';
import 'package:flutter_persistence/pages/dogs/insert.dart';
import 'package:flutter_persistence/pages/dogs/search.dart';
import 'package:flutter_persistence/pages/home.dart';
import 'package:flutter_persistence/pages/path/read-write-files.dart';
import 'package:flutter_persistence/pages/settings/settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Persistence',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Arial",
      ),
      home: HomePage(title: 'Flutter Persistence'),
      routes: <String, WidgetBuilder>{
        DogsSearchPage.routeName: (BuildContext context) => DogsSearchPage(),
        DogsInsertPage.routeName: (BuildContext context) => DogsInsertPage(),
        ReadWriteFilePage.routeName: (BuildContext context) =>
            ReadWriteFilePage(storage: CounterStorage()),
        SettingsPage.routeName: (BuildContext context) => SettingsPage(),
      },
      initialRoute: HomePage.routeName,
    );
  }
}
