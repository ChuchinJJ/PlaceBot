import 'package:flutter/material.dart';
import 'package:placebot/models/Intencion.dart';

class Ruta extends Intencion {
  @override
  llamarAPI() {
    if (parametros.length == 1) {
      respuesta = "Ruta trazada a " + parametros.first.values.first;
    } else {
      respuesta = "Ruta trazada de " +
          parametros.last.values.first +
          " a " +
          parametros.first.values.first;
    }

    mostrar = true;

    return parametros;
  }

  @override
  Widget vista() {
    var h = llamarAPI();

    return ListView(
      children: [Text("Ruta trazada"), Text(h.toString())],
    );
  }
}
