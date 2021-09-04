import 'package:flutter/material.dart';
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
                              var result = await Provider.of<AuthService>(
                                      context,
                                      listen: false)
                                  .createUser(
                                      name: _user,
                                      email: _email,
                                      password: _password);
                              if (result != "login") {
                                _buildErrorDialog(context, result);
                              }
                              Navigator.of(context).pop();
                            } catch (e) {
                              _buildErrorDialog(
                                  context, "Lo sentimos, ha ocurrido un error");
                            }
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
                        onPressed: () => {},
                        child: Text("Politicas de privacidad",
                            style: TextStyle(
                                fontSize: 20,
                                decoration: TextDecoration.underline,
                                height: 0.001))),
                  ])))
        ]));
  }

  Future _buildErrorDialog(BuildContext context, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(_message),
          actions: <Widget>[
            TextButton(
                child: Text('Ok'),
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
