import 'package:flutter/material.dart';
import 'package:flutter_persistence/controller/dogs.dart';
import 'package:flutter_persistence/menu/items.dart';
import 'package:flutter_persistence/models/dogs/dogs.dart';
import 'package:flutter_persistence/pages/dogs/search.dart';

class DogsInsertPage extends StatefulWidget {
  static const String routeName = "/dogs-insert";
  final Dogs dogs;
  DogsInsertPage({this.dogs});

  @override
  _DogsInsertPageState createState() => _DogsInsertPageState();
}

class _DogsInsertPageState extends State<DogsInsertPage> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //String _id = "";
    String _name = "";
    String _age = "";

    return Scaffold(
      appBar: AppBar(
        title: Text("Dogs: ${widget.dogs != null ? 'Update' : 'Insert'}"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _seachPage(context);
              });
            },
          ),
        ],
      ),
      drawer: MenuItems(),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          autovalidate: false,
          onWillPop: () {
            return Future(() => true);
          },
          child: ListView(
            children: [
              Visibility(
                visible: (widget.dogs != null),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: "ID:"),
                        TextSpan(
                            text: widget.dogs != null
                                ? widget.dogs.id.toString()
                                : "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: TextFormField(
                  initialValue: widget.dogs != null ? widget.dogs.name : "",
                  key: Key("Dogs_Insert_Name"),
                  decoration: InputDecoration(
                    hintText: "Name",
                    labelText: "Name",
                  ),
                  onSaved: (value) => _name = value,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: TextFormField(
                  initialValue:
                      (widget.dogs != null ? widget.dogs.age.toString() : ""),
                  key: Key("Dogs_Insert_Age"),
                  decoration: InputDecoration(
                    hintText: "Age",
                    labelText: "Age",
                  ),
                  onSaved: (value) => _age = value,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.green,
                    child: Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      final form = formKey.currentState;
                      if (form.validate()) {
                        form.save();

                        DogsModel dogsModel = new DogsModel();
                        if (isEditing) {
                          dogsModel.updateDog(
                            Dogs(
                              id: widget.dogs.id,
                              age: int.parse(_age),
                              name: _name,
                            ),
                          );
                        } else {
                          dogsModel.insertDog(
                            Dogs(
                              age: int.parse(_age),
                              name: _name,
                            ),
                          );
                        }

                        _seachPage(context);
                      }
                    },
                  ),
                  RaisedButton(
                    color: Colors.red[300],
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _seachPage(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _seachPage(BuildContext context) {
    Navigator.pushReplacementNamed(context, DogsSearchPage.routeName);
  }

  bool get isEditing => widget.dogs != null;
}
