import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myproject/dao/user_dao.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  late List data;

  Future<String> getData() async {
    final tokenUser = await UserDao().getTokenUser();
    var response = await http.get(
        Uri.encodeFull(
            "http://192.168.1.7:8000/api/vacinas/agendamentos/?user=1"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${tokenUser[0]['access']}',
        });

    this.setState(() {
      data = jsonDecode(response.body);
    });

    print(data[1]["title"]);

    return "Success!";
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Listviews"), backgroundColor: Colors.blue),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: new Text(data[index]["local"]),
          );
        },
      ),
    );
  }
}
