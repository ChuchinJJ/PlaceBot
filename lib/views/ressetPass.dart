import 'package:flutter/material.dart';
import 'package:placebot/main.dart';
import 'package:provider/provider.dart';
import '/services/auth.dart';

class RessetPass extends StatefulWidget {
  @override
  RessetPassState createState() => RessetPassState();
}

class RessetPassState extends State<RessetPass> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
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
                    SizedBox(height: 30.0),
                    Container(
                      child: Text(
                        "Ingrese su correo registrado para enviar un enlace de restablecimiento de contraseña",
                        style:
                            TextStyle(color: Colors.deepOrange, fontSize: 20),
                        textAlign: TextAlign.justify,
                      ),
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
                              var result = await Provider.of<AuthService>(
                                      context,
                                      listen: false)
                                  .resetPass(_email);
                              if (result != "send") {
                                _buildErrorDialog(context, result);
                              } else {
                                _buildAdvertenciaDialog(context,
                                    "El email fue enviado, por favor verifique su correo");
                              }
                              print(result);
                            } catch (e) {
                              print(e.toString());
                            }
                          }
                        },
                      ),
                    ),
                  ])))
        ]));
  }

  Future _buildAdvertenciaDialog(BuildContext context, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Advertencia'),
          content: Text(_message),
          actions: <Widget>[
            TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => MyApp()),
                      (route) => false);
                })
          ],
        );
      },
      context: context,
    );
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
