// To parse this JSON data, do
//
//     final agendadamentos = agendadamentosFromJson(jsonString);

import 'dart:convert';

List<Agendadamentos> agendadamentosFromJson(String str) =>
    List<Agendadamentos>.from(
        json.decode(str).map((x) => Agendadamentos.fromJson(x)));

String agendadamentosToJson(List<Agendadamentos> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Agendadamentos {
  Agendadamentos({
    required this.local,
    required this.user,
    required this.status,
    required this.groups,
    required this.datatime,
    required this.age,
  });

  String local;
  int user;
  int status;
  String groups;
  DateTime datatime;
  int age;

  factory Agendadamentos.fromJson(Map<String, dynamic> json) => Agendadamentos(
        local: json["local"],
        user: json["user"],
        status: json["status"],
        groups: json["groups"],
        datatime: DateTime.parse(json["datatime"]),
        age: json["age"],
      );

  Map<String, dynamic> toJson() => {
        "local": local,
        "user": user,
        "status": status,
        "groups": groups,
        "datatime": datatime.toIso8601String(),
        "age": age,
      };
}
