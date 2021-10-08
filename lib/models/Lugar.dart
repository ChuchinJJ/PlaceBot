import 'package:flutter/material.dart';
import 'package:placebot/models/Intencion.dart';

class Lugar extends Intencion {
  @override
  llamarAPI() {
    respuesta = parametros.first.values.first + " encontrado";
    mostrar = true;
    return parametros;
  }

  @override
  Widget vista() {
    var h = llamarAPI();

    return ListView(
      children: [Text("Lugar encontrado"), Text(h.toString())],
    );
  }
}
