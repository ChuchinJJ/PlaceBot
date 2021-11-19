import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:placebot/views/aviso.dart';
import 'package:placebot/views/terminosUso.dart';
import 'package:placebot/widget/AlertDialog.dart';
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
    print(MediaQuery.of(context).size.height);
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
                        labelText: "Correo electrónico",
                        labelStyle: TextStyle(fontSize: 18),
                        hintText: 'Ingrese su correo electrónico',
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
                            var result = await Provider.of<AuthService>(context,
                                    listen: false)
                                .createUser(
                                    name: _user,
                                    email: _email,
                                    password: _password);
                            if (result != "login") {
                              buildErrorDialog(context, result);
                            } else {
                              Navigator.of(context).pop();
                            }
                            print(result);
                          } catch (e) {
                            buildErrorDialog(
                                context, "Lo sentimos, ha ocurrido un error");
                          }
                          setState(() {
                            cargando = false;
                          });
                        }
                      },
                    ),
                  ),
                ]))),
        Container(
          padding: EdgeInsets.all(40),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Al registrarse estas aceptando las ',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                  fontFamily: 'Poppins-Light'),
              children: <TextSpan>[
                TextSpan(
                  text: 'Políticas de privacidad',
                  style: TextStyle(color: Colors.deepOrange),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Aviso()),
                      );
                    },
                ),
                TextSpan(text: " y los "),
                TextSpan(
                  text: 'Términos de uso',
                  style: TextStyle(color: Colors.deepOrange),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Terminos()),
                      );
                    },
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
