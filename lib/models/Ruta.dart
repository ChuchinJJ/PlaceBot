import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:placebot/models/Intencion.dart';

class Ruta extends Intencion {
  @override
  llamarAPI() {
    if (parametros.length == 1) {
      respuesta = "Ruta trazada a " + parametros.first.values.first;
    } else {
      respuesta = "Ruta trazada de " +
          parametros.last.values.first +
          " a " +
          parametros.first.values.first;
    }

    mostrar = true;

    return parametros;
  }

  @override
  Widget vista() {
    GoogleMapController mapController;

    final LatLng _center = const LatLng(19.3911668, -99.4238176);

    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }

    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 11.0,
      ),
    );
  }
}
