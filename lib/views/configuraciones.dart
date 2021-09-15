import 'package:flutter/material.dart';
import 'package:placebot/services/auth.dart';
import 'package:placebot/views/acercaDe.dart';
import 'package:placebot/views/aviso.dart';
import 'package:placebot/views/ayuda.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:placebot/widget/loading.dart';

class PageConfiguracion extends StatelessWidget {
  @override
  Widget build(BuildContext contexto) {
    return Container(
      child: FutureBuilder<User?>(
        future: Provider.of<AuthService>(contexto).getUser(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.error != null) {
              print("error");
              return Text(snapshot.error.toString());
            }
            return Configuracion(snapshot.data);
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}

class Configuracion extends StatefulWidget {
  final User? currentUser;
  Configuracion(this.currentUser);
  @override
  ConfiguracionState createState() => ConfiguracionState();
}

class ConfiguracionState extends State<Configuracion> {
  @override
  Widget build(BuildContext contexto) {
    return Scaffold(
        body: Container(
            margin: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Column(children: <Widget>[
              SizedBox(height: 10),
              ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        NetworkImage("${widget.currentUser!.photoURL}"),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Container(
                      child: Text(
                    "${widget.currentUser!.displayName}",
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                    ),
                  )),
                  subtitle: Container(
                    child: Text("${widget.currentUser!.email}",
                        style:
                            TextStyle(color: Colors.deepOrange, fontSize: 17)),
                  )),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 2.0, color: Colors.deepOrangeAccent)),
                  shape: BoxShape.rectangle,
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      contexto,
                      MaterialPageRoute(builder: (context) => AcercaDe()),
                    );
                  },
                  title: Text("Acerca de",
                      style: TextStyle(color: Colors.deepOrange)),
                  leading: Icon(
                    Icons.info_outline,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      contexto,
                      MaterialPageRoute(builder: (context) => Ayuda()),
                    );
                  },
                  title:
                      Text("Ayuda", style: TextStyle(color: Colors.deepOrange)),
                  leading: Icon(
                    Icons.help_outline,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      contexto,
                      MaterialPageRoute(builder: (context) => Aviso()),
                    );
                  },
                  title: Text("Aviso de privacidad",
                      style: TextStyle(color: Colors.deepOrange)),
                  leading: Icon(
                    Icons.remove_red_eye_outlined,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () async {
                    try {
                      var result = await Provider.of<AuthService>(contexto,
                              listen: false)
                          .logout();
                      print(result);
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  title: Text("Cerrar sesión",
                      style: TextStyle(color: Colors.deepOrange)),
                  leading: Icon(
                    Icons.logout,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              Expanded(child: Text("")),
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(bottom: 10),
                child: Text("Versión 0.1 ARMSoft",
                    style: TextStyle(color: Colors.deepOrange)),
              )
            ])));
  }
}
