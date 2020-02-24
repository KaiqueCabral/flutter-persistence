import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_persistence/controller/settings.dart';
import 'package:flutter_persistence/controller/utils.dart';
import 'package:flutter_persistence/models/settings/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = "/settings";
  final Settings settings;
  SettingsPage({this.settings});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Utils _themeColor;
  Utils _fontFamily;
  Settings _settings;

  List<DropdownMenuItem<Utils>> dropdownThemeColor;
  List<DropdownMenuItem<Utils>> dropdownFontFamily;

  @override
  void initState() {
    super.initState();
    dropdownFontFamily = _listItems(Utils.getFontFamily(), false);
    dropdownThemeColor = _listItems(Utils.getThemeColors(), true);

    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        color: Colors.blue[50],
        child: Form(
          key: formKey,
          autovalidate: false,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            children: <Widget>[
              _label("Theme Color"),
              DropdownButton(
                value: _themeColor,
                isExpanded: true,
                hint: _optionText(dropdownThemeColor.first.value.name, false),
                underline: SizedBox(),
                items: dropdownThemeColor,
                onChanged: (Utils val) {
                  setState(() {
                    _themeColor = val;
                  });
                },
              ),
              SizedBox(
                height: 50,
              ),
              _label("Font Family"),
              DropdownButton(
                value: _fontFamily,
                isExpanded: true,
                hint: _optionText(dropdownFontFamily.first.value.name, true),
                underline: SizedBox(),
                items: dropdownFontFamily,
                onChanged: (Utils val) {
                  setState(() {
                    _fontFamily = val;
                  });
                },
              ),
              SizedBox(
                height: 50,
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

                        SettingsModel settingsModel = new SettingsModel();
                        settingsModel.setUp(
                          Settings(
                            themeColor: _themeColor.id,
                            fontFamily: _fontFamily.id,
                          ),
                        );

                        //_seachPage(context);
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
                      Navigator.of(context).pop();
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

  // void _seachPage(BuildContext context) {
  //   Navigator.of(context).pushReplacementNamed(SettingsPage.routeName);
  // }

  bool get isEditing => widget.settings != null;

  Text _label(String labelText) => Text(
        labelText,
        style: TextStyle(fontSize: 24),
      );

  Text _optionText(String optionText, bool isFont) => Text(
        optionText,
        style: TextStyle(
          fontSize: 20,
          fontFamily: isFont ? optionText : "Arial",
        ),
      );

  Container _container(Color _color, Icon _icon) => Container(
        color: _color,
        child: Center(
          child: _icon,
        ),
        height: 20,
        width: 20,
        margin: EdgeInsets.symmetric(horizontal: 10),
      );

  List<DropdownMenuItem<Utils>> _listItems(List<Utils> lstItems, bool isFont) {
    return lstItems.map((Utils utils) {
      return DropdownMenuItem<Utils>(
        value: utils,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _container(utils.color, utils.icon),
            _optionText(utils.name, isFont),
          ],
        ),
      );
    }).toList();
  }

  Future load() async {
    var _preferences = await SharedPreferences.getInstance();
    var data = _preferences.getString("data");

    if (data != null) {
      _settings = Settings.fromMap(jsonDecode(data));
      setState(() {
        _themeColor = dropdownThemeColor
            .firstWhere(
                (themeColor) => themeColor.value.id == _settings.themeColor)
            .value;
        _fontFamily = dropdownFontFamily
            .firstWhere(
                (fontFamily) => fontFamily.value.id == _settings.fontFamily)
            .value;
      });
    }
  }
}
