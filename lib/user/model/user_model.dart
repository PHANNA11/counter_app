class UserModel {
  int? id;
  String? name;
  String? position;
  int? age;
  double? salary;
  UserModel({
    this.id,
    this.name,
    this.age,
    this.position,
    this.salary,
  });
  Map<String, dynamic> toMap({bool isAdd = false}) {
    return {
      if (isAdd) 'id': id,
      'name': name,
      'age': age,
      'salary': salary,
      'position': position
    };
  }

  UserModel.fromMap({Map<String, dynamic>? map})
      : id = map!['id'],
        name = map['name'],
        age = map['age'],
        salary = map['salary'],
        position = map['position'];
}
