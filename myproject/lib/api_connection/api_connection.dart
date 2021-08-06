import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myproject/model/agendamentos_model.dart';
import 'package:myproject/model/api_model.dart';
import 'package:myproject/dao/user_dao.dart';
import 'package:myproject/login/bloc/login_bloc.dart';

final _base = "http://192.168.1.6:8000";
final _tokenEndpoint = "/api-token-auth/";
final _agendamentosEndpoint = "/api/vacinas/agendamentos?user=";
final _tokenRrefresh = _base + "/api-token-refresh/";
final _idURL = _base + '/rest-auth/login/';
final _tokenURL = _base + _tokenEndpoint;
final _agendamentosURL = _base + _agendamentosEndpoint;

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
    var token = json.decode(response.body);
    print(token['refresh']);
    final http.Response resp =
        await http.post(_tokenRrefresh, body: {'refresh': token['refresh']});
    if (resp.statusCode == 200) {
      var newaccess = json.decode(resp.body);
      token['access'] = newaccess['access'];
      return Token.fromJson(token);
    }
    return Token.fromJson(token);
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future getId(UserLogin userLogin) async {
  print(_tokenURL);
  final http.Response response = await http.post(
    _idURL,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(userLogin.toDatabaseJson()),
  );
  if (response.statusCode == 200) {
    var idjson = json.decode(response.body);
    print(idjson['user']['id']);
    return idjson['user']['id'];
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<List<Agendadamentos>> getAgendamentos() async {
  final tokenUser = await UserDao().getTokenUser();
  final userAux = await UserDao().getUser();
  print(tokenUser[0]['access']);
  print(userAux[0]['email']);
  final http.Response response = await http.get(
    Uri.parse(_agendamentosURL + userAux[0]['email']),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${tokenUser[0]['access']}',
    },
  );
  if (response.statusCode == 200) {
    var list = json.decode(response.body) as List;
    List<Agendadamentos> agendamentos =
        list.map((e) => Agendadamentos.fromJson(e)).toList();
    return agendamentos;
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}
