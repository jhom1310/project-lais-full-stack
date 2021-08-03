import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myproject/api_connection/api_connection.dart';
import 'package:myproject/model/agendamentos_model.dart';
import '../../bloc/auth_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Agendamentos | Comprovante'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: 200.0,
                child: FutureBuilder<List<Agendadamentos>>(
                  future: getAgendamentos(),
                  builder: (context, snapshot) {
                    final users = snapshot.data;

                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      default:
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Algo de errado não está certo!'));
                        } else {
                          return buildUsers(users!);
                        }
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 20.0, 0.0, 0.0),
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

  Widget buildUsers(List<Agendadamentos> users) => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          var status;
          if (user.status == 1) {
            status = 'AGENDADO';
          } else if (user.status == 2) {
            status = 'CANCELADO';
          } else
            status = 'VACINADO';
          return ListTile(
            title: Text(user.local),
            subtitle: Text(
                user.groups + '\n' + user.datatime.toString() + '\n' + status),
            onTap: () {
              if ((user.status == 1) | (user.status == 3)) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailAgnd(agnd: user),
                  ),
                );
              }
            },
          );
        },
      );
}

class DetailAgnd extends StatelessWidget {
  // In the constructor, require a Todo.
  const DetailAgnd({Key? key, required this.agnd}) : super(key: key);

  // Declare a field that holds the Todo.
  final Agendadamentos agnd;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text('Comprovante de Agendamento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text("- COMPROVANTE -\n" +
            "LOCAL: ${agnd.local}\n" +
            "GRUPO: ${agnd.groups}\n" +
            "STATUS: AGENDADO\n" +
            "DATA E HORA: ${agnd.datatime.toString()}\n" +
            ""),
      ),
    );
  }
}
