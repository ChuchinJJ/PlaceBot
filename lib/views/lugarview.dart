import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:placebot/models/JsonMaps.dart';

class LugarView extends StatefulWidget {
  final JsonLugar datos;
  LugarView(this.datos);
  @override
  LugarViewState createState() => LugarViewState(datos);
}

class LugarViewState extends State<LugarView> {
  final JsonLugar datos;
  LugarViewState(this.datos);
  late GoogleMapController mapController;
  late BitmapDescriptor pinPlaceBot;
  Set<Marker> markers = {};

  void setCustomMapPin() async {
    pinPlaceBot = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/pinPlaceBot.png');
  }

  @override
  void initState() {
    super.initState();
    setCustomMapPin();
  }

  @override
  Widget build(BuildContext context) {
    final LatLng _center = LatLng(datos.lat, datos.long);
    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
      setState(() {
        markers.add(Marker(
          markerId: MarkerId(datos.id),
          position: LatLng(
            datos.lat,
            datos.long,
          ),
          infoWindow: InfoWindow(
              title: datos.lugar,
              // ignore: unnecessary_null_comparison
              snippet: datos.rating != null
                  ? "Calificación: " + datos.rating.toString()
                  : ""),
          icon: pinPlaceBot,
        ));
      });
    }

    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 18.0,
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
