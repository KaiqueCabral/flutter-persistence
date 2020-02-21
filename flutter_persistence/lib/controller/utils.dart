import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  int id;
  String name;
  Color color;
  Icon icon;

  Utils(Key key, this.id, this.name, this.color, this.icon);

  static List<Utils> getThemeColors() {
    return <Utils>[
      Utils(Key("NoColor"), 0, "Select a Theme Color", null, null),
      Utils(Key("Color1"), 1, "Blue", Colors.blue, null),
      Utils(Key("Color2"), 3, "Green", Colors.green, null),
      Utils(Key("Color3"), 2, "Orange", Colors.orange, null),
      Utils(Key("Color4"), 4, "Red", Colors.red, null),
      Utils(Key("Color5"), 5, "Yellow", Colors.yellow, null),
    ];
  }

  static List<Utils> getFontFamily() {
    Icon _icon = Icon(Icons.font_download);
    return <Utils>[
      Utils(Key("NoFont"), 0, "Select a Font Family", null, null),
      Utils(Key("Font1"), 1, "Arial", null, _icon),
      Utils(Key("Font2"), 2, "Times New Roman", null, _icon),
      Utils(Key("Font3"), 3, "Verdana", null, _icon),
    ];
  }
}
