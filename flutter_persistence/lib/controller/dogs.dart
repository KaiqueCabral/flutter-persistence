class Dogs {
  final int id;
  final String name;
  final int age;

  Dogs({this.id, this.name, this.age});

  factory Dogs.fromMap(Map<String, dynamic> json) => new Dogs(
        id: json["id"],
        name: json["name"],
        age: json["age"],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}
