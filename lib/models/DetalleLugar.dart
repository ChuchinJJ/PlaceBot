import 'package:flutter/material.dart';
import 'package:placebot/models/Intencion.dart';
import 'package:placebot/models/JsonMaps.dart';
import 'package:placebot/services/googleMaps.dart';
import 'package:placebot/views/detalleView.dart';

class DetalleLugar extends Intencion {
  late String lugar;
  late String placeId;
  late JsonDetalle datos;

  @override
  llamarAPI() async {
    try {
      if (parametros[0].keys.first == "Lugar") {
        lugar = parametros[0]["Lugar"];
        await buscarLugar(lugar).then((valor) {
          if (valor == "Sin_resultados") {
            mostrar = false;
            respuesta = "Lo sentimos, no se encontraron coincidencias";
          } else {
            placeId = valor["place_id"];
          }
        });
      } else {
        lugar = "";
        placeId = parametros[0]["Id"];
      }

      await detalleLugar(placeId).then((valor) {
        if (valor == "Sin_resultados") {
          mostrar = false;
          respuesta = "Lo sentimos, no se encontraron coincidencias";
        } else {
          datos = JsonDetalle.fromJson(valor);
        }
      });
      if (parametros.length == 1) {
        mostrar = true;
        respuesta = "Detalles de " + lugar + " encontrados";
      } else {
        String detalle = parametros[1]["Detalle"].toLowerCase();
        mostrar = false;
        respuesta = obtenerDetalle(detalle);
      }
    } catch (e) {
      print(e);
      mostrar = false;
      respuesta = "Lo sentimos ocurrio un error, intenta de otra forma";
    }
  }

  String obtenerDetalle(String detalle) {
    if (detalle == "telefono" ||
        detalle == "numero de telefono" ||
        detalle == "numero telefonico" ||
        detalle == "número telefónico" ||
        detalle == "teléfono" ||
        detalle == "numero" ||
        detalle == "número" ||
        detalle == "número de teléfono") {
      if (datos.telefono != "") {
        return "Teléfono: " + datos.telefono;
      } else {
        parametros.removeLast();
        return "No se encontró ningún teléfono, puedes presionar este mensaje para ver los detalles generales del lugar";
      }
    } else if (detalle == "sitio web" ||
        detalle == "web" ||
        detalle == "página web" ||
        detalle == "pagina web" ||
        detalle == "website") {
      if (datos.web != "") {
        return "Sitio web: " + datos.web;
      } else {
        parametros.removeLast();
        return "No se encontró ningún sitio web, puedes presionar este mensaje para ver los detalles generales del lugar";
      }
    } else if (detalle == "valoración" ||
        detalle == "valoracion" ||
        detalle == "calificación" ||
        detalle == "estrellas" ||
        detalle == "calificacion") {
      // ignore: unnecessary_null_comparison
      if (datos.rating != null) {
        return "Valoración: " + datos.rating.toString();
      } else {
        parametros.removeLast();
        return "No se encontró ninguna calificación, puedes presionar este mensaje para ver los detalles generales del lugar";
      }
    } else if (detalle == "dirección" ||
        detalle == "dirección completa" ||
        detalle == "direccion" ||
        detalle == "direccion completa") {
      if (datos.direccion != "") {
        return datos.direccion;
      } else {
        parametros.removeLast();
        return "No se encontró ninguna dirección, puedes presionar este mensaje para ver los detalles generales del lugar";
      }
    } else if (detalle == "horario" ||
        detalle == "horarios" ||
        detalle == "horario de apertura") {
      // ignore: unnecessary_null_comparison
      if (datos.abierto != null) {
        String abierto = "abierto";
        if (datos.abierto == false) {
          abierto = "cerrado";
        }
        return datos.nombre + " se encuentra " + abierto;
      } else {
        parametros.removeLast();
        return "No se encontró ninguna coincidencia, puedes presionar este mensaje para ver los detalles generales del lugar";
      }
    } else if (detalle == "estado" ||
        detalle == "estatus" ||
        detalle == "status") {
      if (datos.status != "") {
        if (datos.status == "OPERATIONAL") {
          return datos.nombre + " se encuentra operando";
        } else if (datos.status == "CLOSED_TEMPORARILY") {
          return datos.nombre + " se encuentra cerrado temporalmente";
        }
        return datos.nombre + " se encuentra cerrado permanentemente";
      } else {
        parametros.removeLast();
        return "No se encontró ningún estatus, puedes presionar este mensaje para ver los detalles generales del lugar";
      }
    }
    return "No se encontró ninguna coincidencia, puedes presionar este mensaje para ver los detalles generales del lugar";
  }

  @override
  Widget vista() {
    return DetalleView(datos);
  }
}
