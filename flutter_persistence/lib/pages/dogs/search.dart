import 'package:flutter/material.dart';
import 'package:flutter_persistence/controller/dogs.dart';
import 'package:flutter_persistence/menu/items.dart';
import 'package:flutter_persistence/models/dogs/dogs.dart';
import 'package:flutter_persistence/pages/dogs/insert.dart';

class DogsSearchPage extends StatefulWidget {
  static const String routeName = "/dogs-search";

  @override
  _DogsSearchPageState createState() => _DogsSearchPageState();
}

class _DogsSearchPageState extends State<DogsSearchPage> {
  Future<List<Dogs>> dogs;

  @override
  void initState() {
    super.initState();
    dogs = (new DogsModel()).dogs();
  }

  _dataColumn(String _columnName, bool _isNumeric) => DataColumn(
        label: Text(_columnName),
        numeric: _isNumeric,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dogs: Search"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                Navigator.of(context)
                    .pushReplacementNamed(DogsInsertPage.routeName);
              });
            },
          ),
        ],
      ),
      drawer: MenuItems(),
      body: Container(
        color: Colors.white,
        child: FutureBuilder(
          future: dogs,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            List<Dogs> lstDogs = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '${snapshot.error}',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                } else {
                  return Container(
                    color: Colors.white,
                    constraints: BoxConstraints.expand(),
                    child: DataTable(
                      columns: [
                        _dataColumn("ID", true),
                        _dataColumn("Name", false),
                        _dataColumn("Age", true),
                        _dataColumn("", false),
                      ],
                      rows: lstDogs
                          .map(
                            (dog) => DataRow(
                              cells: [
                                _dataCell(dog.id.toString(), dog.id),
                                _dataCell(dog.name, dog.id),
                                _dataCell(dog.age.toString(), dog.id),
                                DataCell(
                                  Row(
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.grey[500],
                                        ),
                                        onPressed: () {
                                          _pageUpdate(dog.id);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red[300],
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            DogsModel dogsModel =
                                                new DogsModel();
                                            dogsModel.deleteDog(dog.id);
                                            dogs = dogsModel.dogs();
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  );
                }
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  void _pageUpdate(int id) async {
    Dogs dogs = await DogsModel().dogsDetails(id);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DogsInsertPage(dogs: dogs),
      ),
    );
  }

  _dataCell(String value, int id) {
    return DataCell(
      Text(value),
      onTap: () {
        _pageUpdate(id);
      },
    );
  }
}
