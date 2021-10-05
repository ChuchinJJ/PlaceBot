import 'package:flutter/material.dart';
import 'package:placebot/models/Intencion.dart';

class DetalleLugar extends Intencion {
  @override
  llamarAPI() {
    respuesta = "Detalles de " + parametros.first.values.first + " mostrados";
    mostrar = true;

    return parametros;
  }

  @override
  Widget vista() {
    var h = llamarAPI();

    return ListView(
      children: [Text("Detalles de lugar"), Text(h.toString())],
    );
  }
}
