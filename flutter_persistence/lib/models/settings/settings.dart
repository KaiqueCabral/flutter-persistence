import 'dart:convert';

import 'package:flutter_persistence/controller/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsModel {
  Future<Settings> loadSettings() async {
    var preferences = await SharedPreferences.getInstance();
    var data = preferences.getString("data");

    if (data != null) {
      return jsonDecode(data).first;
    }

    return null;
  }

  void setUp(Settings settings) async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.setString("data", jsonEncode(settings.toMap()));
  }
}
