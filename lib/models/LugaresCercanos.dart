import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:placebot/models/Intencion.dart';

class LugaresCercanos extends Intencion {
  @override
  llamarAPI() {
    respuesta = parametros.first.values.first + " encontrados";
    mostrar = true;

    return parametros.toString();
  }

  @override
  Widget vista() {
    var h = llamarAPI();
    GoogleMapController mapController;

    final LatLng _center = const LatLng(16.9085336, -92.1091704);

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
