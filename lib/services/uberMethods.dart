import 'package:geolocator/geolocator.dart';
import 'package:placebot/models/JsonMaps.dart';
import 'package:url_launcher/url_launcher.dart';

import 'geolocator.dart';

linkUberRuta(JsonRuta ruta, String lugar) {
  launch(
      "https://m.uber.com/ul/?client_id=vUBl1jUXoyXMl6crwUJazUmr5-ZfpISF&action=setPickup&pickup[latitude]=" +
          ruta.latOrigen.toString() +
          "&pickup[longitude]=" +
          ruta.longOrigen.toString() +
          "&pickup[nickname]=Mi%20ubicación&pickup[formatted_address]=" +
          ruta.origen +
          "&dropoff[latitude]=" +
          ruta.latDestino.toString() +
          "&dropoff[longitude]=" +
          ruta.longDestino.toString() +
          "&dropoff[nickname]=" +
          lugar +
          "&dropoff[formatted_address]=" +
          ruta.destino);
}

linkUberLugar(JsonLugar lugar) async {
  Position posicion = await determinePosition();
  launch(
      "https://m.uber.com/ul/?client_id=vUBl1jUXoyXMl6crwUJazUmr5-ZfpISF&action=setPickup&pickup[latitude]=" +
          posicion.latitude.toString() +
          "&pickup[longitude]=" +
          posicion.longitude.toString() +
          "&pickup[nickname]=Mi%20ubicación" +
          "&dropoff[latitude]=" +
          lugar.lat.toString() +
          "&dropoff[longitude]=" +
          lugar.long.toString() +
          "&dropoff[nickname]=" +
          lugar.lugar +
          "&dropoff[formatted_address]=" +
          lugar.direccion);
}
