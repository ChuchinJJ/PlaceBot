import 'dart:math';
import 'package:flutter/material.dart';
import 'package:placebot/models/Intencion.dart';

class Traits extends Intencion {
  @override
  llamarAPI() {
    if (tipo == "saludo") {
      var random = new Random();
      respuesta = saludo[random.nextInt(saludo.length)];
    } else if (tipo == "Gracias") {
      var random = new Random();
      respuesta = gracias[random.nextInt(gracias.length)];
    } else if (tipo == "estado") {
    } else {}

    mostrar = false;
  }

  @override
  Widget vista() {
    return Container();
  }
}

List<String> saludo = [
  "Hola",
  "Hola, ¿Comó puedo ayudarte?",
  "Buenos días",
  "Buenas tardes",
  "Buenas noches"
];
List<String> gracias = ["De nada", "Estoy para servirte", "A ti"];
