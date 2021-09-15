import 'package:flutter/material.dart';
import 'package:placebot/views/aviso.dart';
import 'package:provider/provider.dart';
import '/services/auth.dart';

class NuevaCuenta extends StatefulWidget {
  @override
  NuevaCuentaState createState() => NuevaCuentaState();
}

class NuevaCuentaState extends State<NuevaCuenta> {
  final _formKey = GlobalKey<FormState>();
  late String _password;
  late String _user;
  late String _email;

  bool cargando = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Nueva cuenta', style: TextStyle(fontSize: 25)),
          centerTitle: true,
          toolbarHeight: 80,
        ),
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
                        validator: (value) {
                          String pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regExp = new RegExp(pattern);
                          if (value!.isEmpty) {
                            return 'El campo no puede estar vacío';
                          } else if (!regExp.hasMatch(value)) {
                            return "Correo no valido";
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: "Correo eléctronico",
                          labelStyle: TextStyle(fontSize: 18),
                          hintText: 'Ingrese su correo eléctronico',
                          border: OutlineInputBorder(),
                        )),
                    SizedBox(height: 20.0),
                    TextFormField(
                        onSaved: (value) => _user = value!,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'El campo no puede estar vacío';
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: "Usuario",
                          labelStyle: TextStyle(fontSize: 18),
                          hintText: 'Ingrese su usuario',
                          border: OutlineInputBorder(),
                        )),
                    SizedBox(height: 20.0),
                    TextFormField(
                        onSaved: (value) => _password = value!,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'El campo no puede estar vacío';
                          } else {
                            bool minuscula = value.contains(RegExp(r'[a-z]'));
                            bool mayuscula = value.contains(RegExp(r'[A-Z]'));
                            bool numero = value.contains(RegExp(r'[0-9]'));
                            if (value.length <= 8) {
                              return "La contraseña debe contener al menos 8 carácteres";
                            } else if (!minuscula) {
                              return "La contraseña debe contener al menos una minúscula";
                            } else if (!mayuscula) {
                              return "La contraseña debe contener al menos una mayúscula";
                            } else if (!numero) {
                              return "La contraseña debe contener al menos un número";
                            }
                          }
                        },
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
                              setState(() {
                                cargando = true;
                              });
                              var result = await Provider.of<AuthService>(
                                      context,
                                      listen: false)
                                  .createUser(
                                      name: _user,
                                      email: _email,
                                      password: _password);
                              if (result != "login") {
                                _buildErrorDialog(context, result);
                              } else {
                                Navigator.of(context).pop();
                              }
                              print(result);
                            } catch (e) {
                              _buildErrorDialog(
                                  context, "Lo sentimos, ha ocurrido un error");
                            }
                            setState(() {
                              cargando = false;
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Container(
                      child: Text(
                        "Al registrarse estas aceptando las",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Aviso()),
                          );
                        },
                        child: Text("Politicas de privacidad",
                            style: TextStyle(
                                fontSize: 20,
                                decoration: TextDecoration.underline,
                                height: 0.001))),
                  ])))
        ]));
  }

  Future _buildErrorDialog(BuildContext context, _message) {
    String mensaje = _message;
    if (_message == "user-not-found") {
      mensaje = "Usuario no encontrado";
    } else if (_message == "wrong-password") {
      mensaje = "La contraseña es incorrecta";
    } else if (_message == "email-already-in-use") {
      mensaje = "El correo ya está en uso";
    }
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Error',
              style: TextStyle(fontSize: 25, color: Colors.deepOrange)),
          content: Text(
            mensaje,
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
