import 'package:placebot/models/JsonMaps.dart';
import 'package:url_launcher/url_launcher.dart';

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
