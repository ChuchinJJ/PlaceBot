import 'package:flutter/material.dart';
import 'package:placebot/models/Intencion.dart';
import 'package:placebot/models/JsonMaps.dart';
import 'package:placebot/services/googleMaps.dart';
import 'package:placebot/views/lugarview.dart';

class Lugar extends Intencion {
  late String lugar;
  late JsonLugar datos;

  @override
  llamarAPI() async {
    try {
      lugar = parametros[0]["Lugar"];
      await buscarLugar(lugar).then((valor) {
        if (valor == "Sin_resultados") {
          mostrar = false;
          respuesta = "Lo sentimos, no se encontraron coincidencias";
        } else {
          datos = JsonLugar.fromJson(valor);
          respuesta = lugar + " encontrado";
          mostrar = true;
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
    return LugarView(datos);
  }
}
