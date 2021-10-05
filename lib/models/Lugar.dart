import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:placebot/models/Intencion.dart';

class Lugar extends Intencion {
  @override
  llamarAPI() {
    respuesta = parametros.first.values.first + " encontrado";
    mostrar = true;
    return parametros;
  }

  @override
  Widget vista() {
    var h = llamarAPI();

    GoogleMapController mapController;

    final LatLng _center = const LatLng(45.521563, -122.677433);

    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }

    return Text(h.toString());
  }
}
