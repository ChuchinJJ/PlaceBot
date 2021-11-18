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
      respuesta = despedida[random.nextInt(despedida.length)];
    } else if (tipo == "Ayuda") {
      print("algo se envio");
      if (parametros.length != 0) {
        String ayuda = parametros[0]["Ayuda"].toLowerCase();
        if (ayuda.contains("ruta") || ayuda.contains("destino")) {
          respuesta =
              "Puedes solicitar rutas de un lugar en específico a otro, o desde tu posición, por ejemplo: “Traza una ruta del centro de Guadalajara al Lago de Chapala” o “Muestra una ruta al Palacio de bellas Artes”";
        } else if (ayuda.contains("cercano") ||
            ayuda.contains("cercana") ||
            ayuda.contains("rededor")) {
          respuesta =
              "Para buscar establecimientos cercanos puede escribir: “Cafeterías cercanas”, “Cines cercanos a mí”, “Restaurantes a mi alrededor”, etc.";
        } else if (ayuda.contains("foto") || ayuda.contains("imagen")) {
          respuesta =
              "Para ver las fotos de un lugar puede escribir “Fotos del Museo de las momias Guanajuato”";
        } else if (ayuda.contains("detalle")) {
          respuesta =
              "Para ver los detalles de un lugar puede escribir “Detalles del Museo de las momias Guanajuato” o solicitar un dato en específico, “Cual es el número del Museo de las momias Guanajuato”";
        } else if (ayuda.contains("uber")) {
          respuesta =
              "Debe escribir una pregunta solicitando el viaje en Uber e indicando tu destino, por ejemplo: “Viaje en Uber al Museo de las momias Guanajuato”";
        } else if (ayuda.contains("lugar") || ayuda.contains("buscar")) {
          respuesta =
              "Para buscar un lugar puedes escribir “¿Dónde está Six flags México?” o “Donde se encuentra el Palacio de Bellas Artes”";
        } else {
          respuesta =
              "No entendí que tipo de ayuda desaeas, puedes ver la sección de ayuda si lo deseas";
        }
      } else {
        respuesta =
            "Hola, soy Dasha un asistente que te ayudará a buscar lugares, trazar rutas entre muchas otras opciones. Para más información puedes escribir “Ayuda para buscar lugares” o “Ayuda para trazar una ruta”, o puedes ver la sección de ayuda ";
      }
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
  "Hola, ¿Cómo puedo ayudarte?",
  "¿En qué puedo ayudarte?",
  "Hola, ¿Cómo está tu día?",
  "Hola " + Usuario.getNombre().toString(),
  "Hola, ¿En qué te puedo servir?",
  "Hola " + Usuario.getNombre().toString() + ", ¿Cómo te puedo ayudar?",
  "Hola, ¿Qué puedo hacer por ti?",
  "Hola, siempre es un gusto volverte a ver",
  "Hola " + Usuario.getNombre().toString() + ", ¿Qué quieres que hagamos?"
];

List<String> gracias = [
  "De nada",
  "Estoy para servirte",
  "A ti",
  "Es un placer poder ayudarte",
  "Estoy para ayudarte",
  "Cualquier otra cosa que desees puedes pedírmelo",
  "Es un placer",
  "Estoy cuando me necesites"
];

List<String> despedida = [
  "Vuelve cuando quieras",
  "Adiós, recuerda que puedes volver cuando quieras",
  "Que te valla muy bien",
  "Hasta luego",
  "Cuídate",
  "Te voy a extrañar",
  "Vuelve pronto",
  "Adiós",
  "Hasta pronto",
  "Que tengas un excelente día"
];
