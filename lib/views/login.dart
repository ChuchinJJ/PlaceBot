import 'package:flutter/material.dart';
import 'package:placebot/views/nuevaCuenta.dart';
import 'package:placebot/views/ressetPass.dart';
import 'package:provider/provider.dart';
import '/services/auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String _password;
  late String _email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: <Widget>[
      Container(
          padding: EdgeInsets.all(30.0),
          child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                Container(
                  height: 200,
                  child: Image.asset("assets/logoTitulo.png"),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                    onSaved: (value) => _email = value!,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: "Correo eléctronico",
                      labelStyle: TextStyle(fontSize: 18),
                      hintText: 'Ingrese su correo eléctronico',
                      border: OutlineInputBorder(),
                    )),
                SizedBox(height: 20.0),
                TextFormField(
                    onSaved: (value) => _password = value!,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key),
                      labelText: "Contraseña",
                      labelStyle: TextStyle(fontSize: 18),
                      hintText: 'Ingrese su contraseña',
                      border: OutlineInputBorder(),
                    )),
                SizedBox(height: 30.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    child: Text(
                      "Ingresar",
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    onPressed: () async {
                      final form = _formKey.currentState;
                      form!.save();
                      if (form.validate()) {
                        try {
                          var result = await Provider.of<AuthService>(context,
                                  listen: false)
                              .loginWithEmail(
                                  email: _email, password: _password);
                          if (result != "login") {
                            _buildErrorDialog(context, result);
                          }
                        } catch (e) {
                          _buildErrorDialog(
                              context, "Lo sentimos, ha ocurrido un error");
                        }
                      }
                    },
                  ),
                ),
                SizedBox(height: 10.0),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RessetPass()));
                    },
                    child: Text("¿Olvidaste tu contraseña?",
                        style: TextStyle(fontSize: 16))),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20, top: 25),
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 2.0, color: Colors.deepOrangeAccent)),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      child: Text("o",
                          style: TextStyle(
                              color: Colors.deepOrange, fontSize: 18)),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20, top: 25),
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 2.0, color: Colors.deepOrangeAccent)),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: OutlinedButton(
                    child: Text(
                      "Ingresar con Google",
                      style: TextStyle(fontSize: 22, color: Colors.deepOrange),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.deepOrange, width: 2),
                    ),
                    onPressed: () async {
                      try {
                        var result = await Provider.of<AuthService>(context,
                                listen: false)
                            .loginWithGoogle();
                        if (result != "login") {
                          _buildErrorDialog(context, result);
                        }
                      } catch (e) {
                        _buildErrorDialog(
                            context, "Lo sentimos, ha ocurrido un error");
                      }
                    },
                  ),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    child: Text(
                      "Crear cuenta",
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NuevaCuenta()));
                    },
                  ),
                ),
              ])))
    ]));
  }

  Future _buildErrorDialog(BuildContext context, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(
            _message,
            style: TextStyle(fontSize: 20),
          ),
          actions: <Widget>[
            TextButton(
                child: Text(
                  'Ok',
                  style: TextStyle(color: Colors.deepOrange),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }
}
