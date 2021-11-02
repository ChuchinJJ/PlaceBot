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
  late BitmapDescriptor pinPlaceBot;
  Set<Marker> markers = {};
  String dropdownValue = 'Normal';
  MapType tipoMapa = MapType.normal;

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

  void setCustomMapPin() async {
    pinPlaceBot = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/pinPlaceBot.png');
  }

  void cambiarMapa(String tipo) {
    MapType mapa;
    if (tipo == "Terreno") {
      mapa = MapType.terrain;
    } else if (tipo == "Satélite") {
      mapa = MapType.satellite;
    } else {
      mapa = MapType.normal;
    }
    setState(() {
      tipoMapa = mapa;
    });
  }

  @override
  void initState() {
    super.initState();
    getPosicion();
    setCustomMapPin();
  }

  @override
  Widget build(BuildContext context) {
    final LatLng _center = LatLng(0, 0);
    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
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
          icon: pinPlaceBot,
        ));
      }
    }

    return Stack(children: [
      GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 15.0,
        ),
        markers: Set<Marker>.from(markers),
        mapType: tipoMapa,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: true,
        rotateGesturesEnabled: false,
      ),
      Positioned(
          right: 10,
          top: 80,
          child: DropdownButton<String>(
            icon: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.deepOrange, shape: BoxShape.circle),
                child: Icon(Icons.map, color: Colors.white)),
            iconSize: 40,
            underline: Text(''),
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
                cambiarMapa(newValue);
              });
            },
            items: <String>['Normal', 'Satélite', 'Terreno']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )),
    ]);
  }
}
