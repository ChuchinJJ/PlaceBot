import 'package:flutter/material.dart';
import 'package:placebot/services/auth.dart';
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
            child: ListView(children: <Widget>[
              ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    color: Colors.deepOrange,
                    size: 70,
                  ),
                  title: Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Text(
                        "Usuario",
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 22,
                        ),
                      )),
                  subtitle: Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: Text("${widget.currentUser!.email}",
                        style:
                            TextStyle(color: Colors.deepOrange, fontSize: 17)),
                  )),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 2.0, color: Colors.deepOrangeAccent)),
                  shape: BoxShape.rectangle,
                ),
              ),
              Card(
                //color: Colors.deepOrange,
                child: ListTile(
                  onTap: () {
                    /*Navigator.push(
                      contexto,
                      MaterialPageRoute(builder: (context) => Configuraciones()),
                    );*/
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
                //color: Colors.deepOrange,
                child: ListTile(
                  onTap: () {
                    /*Navigator.push(
                      contexto,
                      MaterialPageRoute(builder: (context) => Configuraciones()),
                    );*/
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
                //color: Colors.deepOrange,
                child: ListTile(
                  onTap: () {
                    /*Navigator.push(
                      contexto,
                      MaterialPageRoute(builder: (context) => Configuraciones()),
                    );*/
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
                //color: Colors.deepOrange,
                child: ListTile(
                  onTap: () async {
                    try {
                      await Provider.of<AuthService>(contexto, listen: false)
                          .logout();
                      print("close");
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
              Container(
                alignment: Alignment.bottomCenter,
                height: MediaQuery.of(context).size.height - 550,
                child: Text("Versión 0.1 ARMSoft",
                    style: TextStyle(color: Colors.deepOrange)),
              )
            ])));
  }
}
