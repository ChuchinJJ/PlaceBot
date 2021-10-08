import 'package:flutter/material.dart';
import 'package:placebot/models/Intencion.dart';

class FotosLugar extends Intencion {
  @override
  llamarAPI() {
    respuesta = "Fotos de " + parametros.first.values.first + " mostradas";
    mostrar = true;

    return parametros;
  }

  @override
  Widget vista() {
    var h = llamarAPI();

    return ListView(
      children: [Text("Fotos de lugar"), Text(h.toString())],
    );
  }
}
