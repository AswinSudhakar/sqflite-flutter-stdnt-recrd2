class Studentmodels {
  int? id;

  String? name;

  String? age;
  String? subject;
  String? address;

  Studentmodels(
      {required this.name,
      required this.age,
      required this.subject,
      required this.address,
      this.id});
  static Studentmodels fromMap(Map<String, Object?> map) {
    final id = map['id'] as int;
    final name = map['name'] as String;
    final age = map['age'] as String;
    final subject = map['subject'] as String;
    final address = map['address'] as String;

    return Studentmodels(
        name: name, age: age, subject: subject, address: address, id: id);
  }
}
