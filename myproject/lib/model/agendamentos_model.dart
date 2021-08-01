import 'package:intl/intl.dart';

class Agendamentos {
  int id;
  DateTime datatime;
  int age;
  String status;
  String user;
  String local;
  String groups;

  Agendamentos({
    required this.id,
    required this.datatime,
    required this.age,
    required this.status,
    required this.user,
    required this.local,
    required this.groups,
  });

  factory Agendamentos.fromDatabaseJson(Map<String, dynamic> data) =>
      Agendamentos(
        id: data['id'],
        datatime: data['datatime'],
        age: data['age'],
        status: data['status'],
        user: data['user'],
        local: data['local'],
        groups: data['groups'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        "id": this.id,
        "datatime": this.datatime,
        "age": this.age,
        "status": this.status,
        "user": this.user,
        "local": this.local,
        "groups": this.groups,
      };

  factory Agendamentos.fromJson(Map<String, dynamic> json) {
    var datatime = DateTime.parse(json['datatime']);
    //new DateFormat("yyyy-MM-dd", "en_US").parse(json['datatime']);
    return Agendamentos(
        id: json['id'],
        datatime: datatime,
        age: json['age'],
        status: json['status'],
        user: json['user'],
        local: json['local'],
        groups: json['groups']);
  }

  factory Agendamentos.fromJsonList(Map<String, dynamic> json) {
    return Agendamentos(
        id: json['id'],
        datatime: json['datatime'],
        age: json['age'],
        status: json['status'],
        user: json['user'],
        local: json['local'],
        groups: json['groups']);
  }
}
