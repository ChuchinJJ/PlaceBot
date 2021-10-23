import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:placebot/models/JsonMaps.dart';

class RutaView extends StatefulWidget {
  final JsonRuta datos;
  RutaView(this.datos);
  @override
  RutaViewState createState() => RutaViewState(datos);
}

class RutaViewState extends State<RutaView> {
  final JsonRuta datos;
  RutaViewState(this.datos);
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  late BitmapDescriptor pinPlaceBot;

  _createPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyBh6-q7wJ8FWjMt-mTSgxGSEHwwPFYBK1Y",
      PointLatLng(datos.latOrigen, datos.longOrigen),
      PointLatLng(datos.latDestino, datos.longDestino),
      travelMode: TravelMode.driving,
    );

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

    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 18.0,
      ),
      markers: Set<Marker>.from(markers),
      polylines: Set<Polyline>.of(polylines.values),
      mapType: MapType.terrain,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: true,
      rotateGesturesEnabled: false,
    );
  }
}
