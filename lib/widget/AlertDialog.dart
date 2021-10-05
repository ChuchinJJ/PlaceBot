import 'package:flutter/material.dart';
import 'package:placebot/main.dart';

Future buildErrorDialog(BuildContext context, _message) {
  String mensaje = _message;
  if (_message == "user-not-found") {
    mensaje = "Usuario no encontrado";
  } else if (_message == "wrong-password") {
    mensaje = "La contraseña es incorrecta";
  } else if (_message == "email-already-in-use") {
    mensaje = "El usuario ya está registrado";
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

Future buildAdvertenciaDialog(BuildContext context, _message) {
  return showDialog(
    builder: (context) {
      return AlertDialog(
        title: Text('Advertencia',
            style: TextStyle(fontSize: 25, color: Colors.deepOrange)),
        content: Text(_message),
        actions: <Widget>[
          TextButton(
              child: Text('Ok', style: TextStyle(color: Colors.deepOrange)),
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
