import 'package:flutter/material.dart';
import 'package:placebot/models/Intencion.dart';

class LugaresCercanos extends Intencion {
  @override
  llamarAPI() {
    respuesta = parametros.first.values.first + " encontrados";
    mostrar = true;

    return parametros;
  }

  @override
  Widget vista() {
    var h = llamarAPI();

    return ListView(
      children: [Text("Lugares buscados"), Text(h.toString())],
    );
  }
}
