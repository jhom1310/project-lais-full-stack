import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myproject/api_connection/api_connection.dart';
import 'package:myproject/bloc/auth_bloc.dart';
import 'package:myproject/model/agendamentos_model.dart';

class Exemplo extends StatefulWidget {
  const Exemplo({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Exemplo> {
  late Future<Agendamentos> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = getAgendamentos();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Meu Agendamento'),
        ),
        body: Column(
          children: [
            FutureBuilder<Agendamentos>(
              future: futureAlbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                      '${snapshot.data!.local}\n${snapshot.data!.datatime}\n');
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(34.0, 20.0, 0.0, 0.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.width * 0.16,
                child: RaisedButton(
                  child: Text(
                    'Sair',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(LoggedOut());
                  },
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
