import 'package:flutter/material.dart';
import 'package:placebot/models/Intencion.dart';
import 'package:placebot/services/googleMaps.dart';
import 'package:placebot/views/fotosView.dart';

class FotosLugar extends Intencion {
  late String lugar;
  late String placeId;
  late List<String> referencias = [];

  @override
  llamarAPI() async {
    try {
      lugar = parametros[0]["Lugar"];

      await buscarLugar(lugar).then((valor) {
        if (valor == "Sin_resultados") {
          mostrar = false;
          respuesta = "Lo sentimos, no se encontraron coincidencias";
        } else {
          placeId = valor["place_id"];
        }
      });

      await detalleLugar(placeId).then((valor) {
        if (valor == "Sin_resultados") {
          mostrar = false;
          respuesta = "Lo sentimos, no se encontraron coincidencias";
        } else {
          var arrayFotos = valor["photos"];
          for (var lista in arrayFotos) {
            String referencia = lista["photo_reference"];
            referencias.add(referencia);
          }
          mostrar = true;
          respuesta = "Fotos de " + lugar;
        }
      });
    } catch (e) {
      print(e);
      mostrar = false;
      respuesta = "Lo sentimos ocurrio un error, intenta de otra forma";
    }
  }

  @override
  Widget vista() {
    return FotosView(referencias);
  }
}
