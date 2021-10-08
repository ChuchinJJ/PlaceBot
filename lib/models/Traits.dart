import 'dart:math';
import 'package:flutter/material.dart';
import 'package:placebot/models/Intencion.dart';
import 'package:placebot/models/user.dart';

class Traits extends Intencion {
  @override
  llamarAPI() {
    if (tipo == "Saludo") {
      var random = new Random();
      respuesta = saludo[random.nextInt(saludo.length)];
    } else if (tipo == "Gracias") {
      var random = new Random();
      respuesta = gracias[random.nextInt(gracias.length)];
    } else if (tipo == "Despedida") {
      var random = new Random();
      respuesta = gracias[random.nextInt(gracias.length)];
    } else if (tipo == "Ayuda"){

    }else{
      
    }

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
  "¿En que puedo ayudarte?",
  "Hola, ¿Comó está tu día?",
  "Hola " + Usuario.getNombre().toString(),
  "Hola, ¿En qué te puedo servir?"
          "Hola " +
      Usuario.getNombre().toString() +
      ", ¿Cómo te puedo ayudar?",
  "Hola, ¿Qué puedo hacer por ti",
  "Hola, siempre es un gusto volverte a ver",
  "Holi"
];

List<String> gracias = [
  "De nada",
  "Estoy para servirte",
  "A ti",
  "Es un placer poder ayudarte",
  "Estoy para ayudarte",
  "Cualquier otra cosa que desees puedes pedirmelo",
  "Es un placer",
  "Para eso estoy"
];

List<String> despedida = [
  "Vuelve cuando quieras",
  "Adiós, recuerda que puedes volver cuando quieras",
  "Que te valla muy bien",
  "Hasta luego",
  "Cuídate",
  "Adiós",
  "Hasta pronto",
  "Que tengas un excelente día"
];
