import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:placebot/models/JsonMaps.dart';
import 'package:placebot/services/googleMaps.dart';

class RutaView extends StatefulWidget {
  final JsonRuta datos;
  RutaView(this.datos);
  @override
  RutaViewState createState() => RutaViewState(datos);
}

class RutaViewState extends State<RutaView> with TickerProviderStateMixin {
  late JsonRuta datos;
  RutaViewState(this.datos);
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  late BitmapDescriptor pinPlaceBot;
  MapType tipoMapa = MapType.normal;
  TravelMode modoViaje = TravelMode.driving;
  String tipoViaje = "Automóvil";
  Icon iconoViaje = Icon(Icons.directions_car, color: Colors.white);
  String dropdownValue = 'Normal';
  List<String> options = <String>['Automóvil', 'Caminando', 'Bicicleta'];

  _createPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyBh6-q7wJ8FWjMt-mTSgxGSEHwwPFYBK1Y",
        PointLatLng(datos.latOrigen, datos.longOrigen),
        PointLatLng(datos.latDestino, datos.longDestino),
        travelMode: modoViaje);

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id = PolylineId('poly');

    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepOrange,
      points: polylineCoordinates,
      width: 3,
    );

    polylines[id] = polyline;
    setState(() {});
  }

  void setCustomMapPin() async {
    pinPlaceBot = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/pinPlaceBot.png');
  }

  void cambiarMapa(String tipo) {
    MapType mapa;
    if (tipo == "Terreno") {
      mapa = MapType.terrain;
    } else if (tipo == "Satelite") {
      mapa = MapType.satellite;
    } else {
      mapa = MapType.normal;
    }
    setState(() {
      tipoMapa = mapa;
    });
  }

  void cambiarViaje(String modo) async {
    String origen =
        datos.latOrigen.toString() + "," + datos.longOrigen.toString();
    String destino =
        datos.latDestino.toString() + "," + datos.longDestino.toString();
    String mode = "driving";
    if (modo == "Bicicleta") {
      mode = "bicycling";
      modoViaje = TravelMode.bicycling;
      iconoViaje = Icon(Icons.directions_bike, color: Colors.white);
    } else if (modo == "Caminando") {
      mode = "walking";
      modoViaje = TravelMode.walking;
      iconoViaje = Icon(Icons.directions_walk, color: Colors.white);
    } else {
      modoViaje = TravelMode.driving;
      iconoViaje = Icon(Icons.directions_car, color: Colors.white);
    }
    await trazarRuta(origen, destino, mode).then((valor) {
      if (valor != "Sin_resultados") {
        datos = JsonRuta.fromJson(valor);
      }
    });
    polylines.clear();
    polylineCoordinates.clear();
    await _createPolylines();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setCustomMapPin();
    _createPolylines();
  }

  @override
  Widget build(BuildContext context) {
    final LatLng _center = LatLng(datos.latOrigen, datos.longOrigen);
    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(
              datos.noreste["lat"],
              datos.noreste["lng"],
            ),
            southwest: LatLng(
              datos.suroeste["lat"],
              datos.suroeste["lng"],
            ),
          ),
          50.0,
        ),
      );

      markers.add(Marker(
        markerId: MarkerId("1"),
        position: LatLng(
          datos.latOrigen,
          datos.longOrigen,
        ),
        infoWindow: InfoWindow(
          title: datos.origen,
        ),
        icon: pinPlaceBot,
      ));

      markers.add(Marker(
        markerId: MarkerId("2"),
        position: LatLng(
          datos.latDestino,
          datos.longDestino,
        ),
        infoWindow: InfoWindow(
          title: datos.destino,
        ),
        icon: pinPlaceBot,
      ));
    }

    Widget _bottomShet(BuildContext context) {
      return Container(
        child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  datos.duracion + " (" + datos.distancia + ")",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                DropdownButton<String>(
                  value: tipoViaje,
                  icon: iconoViaje,
                  iconSize: 35,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontFamily: "Poppins"),
                  dropdownColor: Colors.white,
                  underline: Text(''),
                  selectedItemBuilder: (BuildContext context) {
                    return options.map((String value) {
                      return Container(
                          padding: EdgeInsets.only(top: 10, right: 15),
                          child: Text(
                            tipoViaje,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ));
                    }).toList();
                  },
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  onChanged: (String? newValue) {
                    setState(() {
                      tipoViaje = newValue!;
                      cambiarViaje(newValue);
                    });
                  },
                  items: options.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            )),
      );
    }

    return Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: Scaffold(
            body: Stack(children: [
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 18.0,
                ),
                markers: Set<Marker>.from(markers),
                polylines: Set<Polyline>.of(polylines.values),
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
                    items: <String>['Normal', 'Satelite', 'Terreno']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
            ]),
            bottomSheet: BottomSheet(
              backgroundColor: Colors.deepOrangeAccent,
              constraints: BoxConstraints(
                  minHeight: 110, minWidth: MediaQuery.of(context).size.width),
              onClosing: () {},
              builder: _bottomShet,
              enableDrag: true,
              animationController: BottomSheet.createAnimationController(this),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
            )));
  }
}
