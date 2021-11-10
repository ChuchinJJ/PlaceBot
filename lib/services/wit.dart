import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_witai/flutter_witai.dart';
import 'package:placebot/models/DetalleLugar.dart';
import 'package:placebot/models/FotosLugar.dart';
import 'package:placebot/models/Intencion.dart';
import 'package:placebot/models/Lugar.dart';
import 'package:placebot/models/LugaresCercanos.dart';
import 'package:placebot/models/Ruta.dart';
import 'package:placebot/models/Traits.dart';
import 'package:placebot/models/Uber.dart';

class WitMethods {
  static respuestaWit(
      String texto, enviarMensaje, setCargando, BuildContext context) async {
    setCargando(true);
    final wit = WitManager(
        utterance: texto,
        headers: "D4TTIQVLQQV4YYZPSJ77HKLYT2XHRENK",
        params: "message");
    dynamic response = await wit.fetchLink();

    //aquí va la lógica de respuesta
    var intents = response["intents"];
    var entities = response["entities"].values;
    if (intents.length == 0 || entities.length == 0) {
      Intencion intencion = Traits();
      intencion.construct("Error", []);
      var random = new Random();
      enviarMensaje(error[random.nextInt(error.length)], intencion);
    } else if (intents[0]["confidence"] < 0.65) {
      Intencion intencion = Traits();
      intencion.construct("Error", []);
      enviarMensaje(
          "No estoy completamente seguro de lo que solicitas", intencion);
    } else {
      String intentName = intents[0]["name"];
      List<Map> parametros = [];
      for (var entidad in entities) {
        parametros.add({entidad[0]["name"]: entidad[0]["value"]});
      }

      await fabrica(intentName, parametros, context).then((value) {
        enviarMensaje(value.respuesta, value);
        if (value.mostrar) {
          value.mostrarVista(context);
        }
      });
    }
    setCargando(false);
  }

  //factory method
  static Future<Intencion> fabrica(
      String tipoIntencion, List<Map> parametros, BuildContext context) async {
    Intencion intencion;
    if (tipoIntencion == "Ruta") {
      intencion = Ruta();
    } else if (tipoIntencion == "Lugar") {
      intencion = Lugar();
    } else if (tipoIntencion == "LugaresCercanos") {
      intencion = LugaresCercanos();
    } else if (tipoIntencion == "Detalles") {
      intencion = DetalleLugar();
    } else if (tipoIntencion == "Fotos") {
      intencion = FotosLugar();
    } else if (tipoIntencion == "Uber") {
      intencion = Uber();
    } else {
      intencion = Traits();
    }
    intencion.construct(tipoIntencion, parametros);
    await intencion.llamarAPI();
    return intencion;
  }
}

List<String> error = [
  "Lo siento, no entendí tu pregunta, puedes intentar de otra forma",
  "Perdon, no pude comprender tu prengunta, intenta de otra forma",
  "Lo siento, no te entendí",
  "Hubo un problema, por favor intenta de otra forma",
  "No pude comprenderte, estamos trabajando para mejorar la atención",
  "Por favor prueba de otra forma, puedes pedirme ayuda si lo deseas",
  "Una disculpa, no entendí lo que solicitaste",
  "Lo siento, no te puedo ayudar, prueba de otra forma",
  "Perdon, pero no te pude comprender",
  "No te entendí, podrías intentar de otra forma"
];
