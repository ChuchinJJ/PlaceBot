import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:placebot/services/geolocator.dart';

String key = "AIzaSyBh6-q7wJ8FWjMt-mTSgxGSEHwwPFYBK1Y";

buscarLugar(String ubicacion) async {
  final response = await http.get(Uri.parse(
      'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=' +
          ubicacion +
          '&inputtype=textquery&key=' +
          key +
          '&fields=formatted_address,geometry,name,photo,place_id,type,business_status,opening_hours,user_ratings_total'));
  if (response.statusCode == 200) {
    if (jsonDecode(response.body)["status"] == "OK") {
      var valor = jsonDecode(response.body)["candidates"][0];
      return valor;
    }
    return "Sin_resultados";
  } else {
    return "Sin_resultados";
  }
}

trazarRuta(String origen, String destino) async {
  if (origen == "") {
    Position posicion = await determinePosition();
    origen = posicion.latitude.toString() + "," + posicion.longitude.toString();
  }
  final response = await http.get(Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json?origin=' +
          origen +
          '&destination=' +
          destino +
          '&key=' +
          key +
          '&mode=driving'));
  if (response.statusCode == 200) {
    Map<String, dynamic> respuestaJson = jsonDecode(response.body);
    if (respuestaJson["status"] == "OK") {
      var valor = respuestaJson["routes"][0];
      return valor;
    }
    return "Sin_resultados";
  } else {
    return "Sin_resultados";
  }
}

buscarTipoLugar(String tipoLugar) async {
  Position posicion = await determinePosition();
  final response = await http.get(Uri.parse(
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=" +
          posicion.latitude.toString() +
          "," +
          posicion.longitude.toString() +
          "&radius=1000&type=" +
          tipoLugar +
          "&key=" +
          key));
  if (response.statusCode == 200) {
    if (jsonDecode(response.body)["status"] == "OK") {
      var valor = jsonDecode(response.body)["results"];
      return valor;
    }
    return "Sin_resultados";
  } else {
    return "Sin_resultados";
  }
}

buscarLugaresTexto(String busqueda) async {
  Position posicion = await determinePosition();
  final response = await http.get(Uri.parse(
      "https://maps.googleapis.com/maps/api/place/textsearch/json?location=" +
          posicion.latitude.toString() +
          "," +
          posicion.longitude.toString() +
          "&query=" +
          busqueda +
          "&radius=1000&key=" +
          key));
  if (response.statusCode == 200) {
    if (jsonDecode(response.body)["status"] == "OK") {
      var valor = jsonDecode(response.body)["results"];
      return valor;
    }
    return "Sin_resultados";
  } else {
    return "Sin_resultados";
  }
}
