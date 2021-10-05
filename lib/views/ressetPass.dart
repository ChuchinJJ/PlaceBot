import 'package:flutter/material.dart';
import 'package:placebot/widget/AlertDialog.dart';
import 'package:provider/provider.dart';
import '/services/auth.dart';

class RessetPass extends StatefulWidget {
  @override
  RessetPassState createState() => RessetPassState();
}

class RessetPassState extends State<RessetPass> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  bool cargando = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Restablecer contraseña', style: TextStyle(fontSize: 25)),
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
                    SizedBox(height: 60.0),
                    Container(
                      child: Text(
                        "Ingrese su correo registrado para enviar un enlace de restablecer contraseña",
                        style: TextStyle(color: Colors.black54, fontSize: 20),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(height: 40.0),
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
                    SizedBox(height: 30.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton(
                        child: Text(
                          "Enviar enlace",
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
                                  .resetPass(_email);
                              if (result != "send") {
                                buildErrorDialog(context, result);
                              } else {
                                buildAdvertenciaDialog(context,
                                    "El email fue enviado, por favor verifique su correo");
                              }
                              print(result);
                            } catch (e) {
                              print(e.toString());
                            }
                            setState(() {
                              cargando = false;
                            });
                          }
                        },
                      ),
                    ),
                  ])))
        ]));
  }
}
