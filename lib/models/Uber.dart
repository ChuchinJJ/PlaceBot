import 'package:flutter/material.dart';
import 'package:placebot/models/Intencion.dart';
import 'package:placebot/models/JsonMaps.dart';
import 'package:placebot/services/googleMaps.dart';
import 'package:placebot/services/uberMethods.dart';

class Uber extends Intencion {
  late String lugar;
  late JsonRuta ruta;

  @override
  llamarAPI() async {
    try {
      lugar = parametros[0]["Destino"];
      await trazarRuta("", lugar, "driving").then((valor) {
        if (valor == "Sin_resultados") {
          mostrar = false;
          respuesta = "Lo sentimos, no se encontraron coincidencias";
        } else {
          ruta = JsonRuta.fromJson(valor);
          respuesta = "Viaje en Uber a " + lugar + " mostrado";
          linkUberRuta(ruta, lugar);
          mostrar = false;
        }
      });
    } catch (e) {
      print(e);
      mostrar = false;
      respuesta = "Lo sentimos ocurrió un error, intenta de otra forma";
    }
  }

  @override
  Widget vista() {
    return Container();
  }
}
