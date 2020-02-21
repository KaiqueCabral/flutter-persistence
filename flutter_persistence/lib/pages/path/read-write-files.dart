import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_persistence/menu/items.dart';
import 'package:path_provider/path_provider.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       title: 'Reading and Writing Files',
//       home: ReadWriteFilePage(storage: CounterStorage()),
//     ),
//   );
// }

class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$counter');
  }
}

class ReadWriteFilePage extends StatefulWidget {
  static const String routeName = "/read-write-file";
  final CounterStorage storage;

  ReadWriteFilePage({Key key, @required this.storage}) : super(key: key);

  @override
  _ReadWriteFilePageState createState() => _ReadWriteFilePageState();
}

class _ReadWriteFilePageState extends State<ReadWriteFilePage> {
  int _counter;

  @override
  void initState() {
    super.initState();
    widget.storage.readCounter().then((int value) {
      setState(() {
        _counter = value;
      });
    });
  }

  Future<File> _incrementCounter() {
    setState(() {
      _counter++;
    });

    // Write the variable as a string to the file.
    return widget.storage.writeCounter(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reading and Writing Files')),
      drawer: MenuItems(),
      body: Center(
        child: Text(
          'Button tapped $_counter time${_counter == 1 ? '' : 's'}.',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
