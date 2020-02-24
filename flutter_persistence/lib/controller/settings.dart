class Settings {
  int themeColor;
  int fontFamily;

  Settings({this.themeColor, this.fontFamily});

  factory Settings.fromMap(Map<String, dynamic> json) => new Settings(
        themeColor: int.tryParse(json["themeColor"]),
        fontFamily: int.tryParse(json["fontFamily"]),
      );

  Map<String, dynamic> toMap() {
    return {
      'themeColor': themeColor,
      'fontFamily': fontFamily,
    };
  }
}
