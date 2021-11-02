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
  String dropdownValue = 'Normal';
  MapType tipoMapa = MapType.normal;

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

    return Stack(children: [
      GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 18.0,
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
