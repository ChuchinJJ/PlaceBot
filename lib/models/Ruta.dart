import 'package:flutter/material.dart';
import 'package:placebot/models/Intencion.dart';
import 'package:placebot/models/JsonMaps.dart';
import 'package:placebot/services/googleMaps.dart';
import 'package:placebot/views/RutaView.dart';

class Ruta extends Intencion {
  static late JsonRuta datos;
  @override
  llamarAPI() async {
    try {
      if (parametros.length == 1) {
        String destino = parametros[0]["Destino"];
        await trazarRuta("", destino, "driving").then((valor) {
          if (valor == "Sin_resultados") {
            mostrar = false;
            respuesta = "Lo sentimos, no se encontraron coincidencias";
          } else {
            datos = JsonRuta.fromJson(valor);
            respuesta = "Ruta trazada a " + destino;
            mostrar = true;
          }
        });
      } else {
        String origen = parametros[1]["Origen"];
        String destino = parametros[0]["Destino"];
        await trazarRuta(origen, destino, "driving").then((valor) {
          if (valor == "Sin_resultados") {
            mostrar = false;
            respuesta = "Lo sentimos, no se encontraron coincidencias";
          } else {
            datos = JsonRuta.fromJson(valor);
            respuesta = "Ruta trazada de " + origen + " a " + destino;
            mostrar = true;
          }
        });
      }
    } catch (e) {
      print(e);
      mostrar = false;
      respuesta = "Lo sentimos ocurrió un error, intenta de otra forma";
    }
  }

  @override
  Widget vista() {
    return RutaView(datos);
  }
}
