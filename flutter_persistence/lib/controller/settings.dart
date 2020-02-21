class Settings {
  String themeColor;
  String fontFamily;

  Settings({this.themeColor, this.fontFamily});

  factory Settings.fromMap(Map<String, dynamic> json) => new Settings(
        themeColor: json["themeColor"],
        fontFamily: json["fontFamily"],
      );

  Map<String, dynamic> toMap() {
    return {
      'themeColor': themeColor,
      'fontFamily': fontFamily,
    };
  }
}
