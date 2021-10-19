import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:placebot/models/JsonMaps.dart';
import 'package:placebot/services/geolocator.dart';

class LugaresCercanosView extends StatefulWidget {
  final List<JsonLugar> datos;
  LugaresCercanosView(this.datos);
  @override
  LugaresCercanosViewState createState() => LugaresCercanosViewState(datos);
}

class LugaresCercanosViewState extends State<LugaresCercanosView> {
  final List<JsonLugar> datos;
  LugaresCercanosViewState(this.datos);
  late GoogleMapController mapController;

  getPosicion() async {
    await determinePosition().then((position) {
      setState(() {
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 15.0,
            ),
          ),
        );
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getPosicion();
  }

  @override
  Widget build(BuildContext context) {
    final LatLng _center = LatLng(0, 0);
    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }

    Set<Marker> markers = {};

    for (var lugar in datos) {
      markers.add(Marker(
        markerId: MarkerId(lugar.id),
        position: LatLng(
          lugar.lat,
          lugar.long,
        ),
        infoWindow: InfoWindow(
            title: lugar.lugar,
            // ignore: unnecessary_null_comparison
            snippet: lugar.rating != null
                ? "Calificación: " + lugar.rating.toString()
                : ""),
        icon: BitmapDescriptor.defaultMarkerWithHue(15),
      ));
    }

    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 15.0,
      ),
      markers: Set<Marker>.from(markers),
      mapType: MapType.terrain,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: true,
      rotateGesturesEnabled: false,
    );
  }
}
