import 'package:flutter/material.dart';
import 'package:placebot/models/Intencion.dart';
import 'package:placebot/services/googleMaps.dart';
import 'package:placebot/views/lugarview.dart';

class Lugar extends Intencion {
  late String lugar;
  static late JsonLugar datos;

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
      respuesta = "Lo sentimos ocurrio un error, intenta de otra forma";
    }
    return parametros;
  }

  @override
  Widget vista() {
    return LugarView(datos);
  }
}

class JsonLugar {
  final String id;
  final String lugar;
  final double lat;
  final double long;
  final String direccion;
  final String fotoUrl;
  final double rating;
  final List<dynamic> types;

  JsonLugar(
      {required this.id,
      required this.lugar,
      required this.lat,
      required this.long,
      required this.direccion,
      required this.fotoUrl,
      required this.rating,
      required this.types});

  factory JsonLugar.fromJson(Map<String, dynamic> json) {
    return JsonLugar(
        id: json["place_id"],
        lugar: json["name"],
        lat: json["geometry"]["location"]["lat"],
        long: json["geometry"]["location"]["lng"],
        direccion: json["formatted_address"],
        fotoUrl: json["photos"][0]["photo_reference"],
        rating: json["rating"],
        types: json["types"]);
  }
}
