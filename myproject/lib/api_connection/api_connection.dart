import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myproject/model/agendamentos_model.dart';
import 'package:myproject/model/api_model.dart';
import 'package:myproject/dao/user_dao.dart';

final _base = "http://192.168.1.7:8000";
final _tokenEndpoint = "/api-token-auth/";
final _agendamentosEndpoint = "/api/vacinas/agendamentos/1/";
final _agendamentosURL = _base + _agendamentosEndpoint;
final _tokenURL = _base + _tokenEndpoint;
final _tokenRrefresh = "/api-token-refresh/";

Future<Token> getToken(UserLogin userLogin) async {
  print(_tokenURL);
  final http.Response response = await http.post(
    _tokenURL,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(userLogin.toDatabaseJson()),
  );
  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<Agendamentos> getAgendamentos() async {
  final tokenUser = await UserDao().getTokenUser();
  print(tokenUser[0]['access']);
  final http.Response response = await http.get(
    Uri.parse(_agendamentosURL),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${tokenUser[0]['access']}',
    },
  );
  if (response.statusCode == 200) {
    return Agendamentos.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());

    throw Exception(json.decode(response.body));
  }
}
