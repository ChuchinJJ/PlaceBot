import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:placebot/models/DetalleLugar.dart';
import 'package:placebot/models/JsonMaps.dart';
import 'package:placebot/models/Ruta.dart';
import 'package:placebot/services/geolocator.dart';
import 'package:placebot/services/googleMaps.dart';
import 'package:placebot/services/uberMethods.dart';
import 'package:placebot/widget/SnackBar.dart';
import 'package:placebot/widget/loading.dart';

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
    final LatLng _center = LatLng(datos[0].lat, datos[0].long);
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
            ),
            icon: pinPlaceBot,
            onTap: () {
              Scaffold.of(context).showBottomSheet<void>(
                (BuildContext context) {
                  return DraggableScrollableSheet(
                      maxChildSize: 0.90,
                      minChildSize: 0.30,
                      initialChildSize: 0.40,
                      expand: false,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return Container(
                            child: Padding(
                                padding: EdgeInsets.only(left: 20.0, right: 20),
                                child: ListView(
                                    controller: scrollController,
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        lugar.lugar,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontFamily: "Poppins-Medium"),
                                      ),
                                      // ignore: unnecessary_null_comparison
                                      if (lugar.rating != null)
                                        Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(
                                              bottom: 10, top: 20),
                                          child: RatingBarIndicator(
                                            rating: lugar.rating,
                                            direction: Axis.horizontal,
                                            itemBuilder: (context, index) =>
                                                Icon(
                                              Icons.star,
                                              color: Colors.white,
                                            ),
                                            itemSize: 30,
                                            unratedColor: Color.fromRGBO(
                                                176, 176, 176, 100),
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 1.0),
                                          ),
                                        ),
                                      // ignore: unnecessary_null_comparison
                                      if (lugar.rating != null &&
                                          // ignore: unnecessary_null_comparison
                                          lugar.votos != null)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "Calificación: " +
                                                  lugar.rating.toString(),
                                              style: TextStyle(
                                                  fontFamily: "Poppins-Light",
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              lugar.votos.toString() + ' votos',
                                              style: TextStyle(
                                                  fontFamily: "Poppins-Light",
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      // ignore: unnecessary_null_comparison
                                      if (lugar.rating != null)
                                        Divider(
                                          color: Colors.white,
                                        ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      if (lugar.fotoUrl != "")
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              fotosLugar(lugar.fotoUrl),
                                            )),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton.icon(
                                                label: Text(
                                                  "Trazar ruta",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.deepOrange),
                                                ),
                                                icon: Icon(
                                                  Icons.directions_outlined,
                                                  color: Colors.deepOrange,
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                    ),
                                                    fixedSize: Size(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2,
                                                        50),
                                                    primary: Colors.white),
                                                onPressed: () async {
                                                  showLoading(context);
                                                  Ruta ruta = new Ruta();
                                                  List<Map> parametros = [
                                                    {
                                                      "Destino": lugar.lat
                                                              .toString() +
                                                          "," +
                                                          lugar.long.toString()
                                                    }
                                                  ];
                                                  ruta.construct(
                                                      "Ruta", parametros);
                                                  await ruta.llamarAPI();
                                                  Navigator.of(context).pop();
                                                  if (ruta.mostrar == true) {
                                                    ruta.mostrarVista(context);
                                                  } else {
                                                    snackBarError(context,
                                                        "Lo sentimos, no se pudo procesar su solicitud");
                                                  }
                                                })
                                          ]),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Divider(
                                        color: Colors.white,
                                      ),
                                      if (lugar.direccion != "")
                                        ListTile(
                                          title: Text(
                                            lugar.direccion,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontFamily: "Poppins-Regular"),
                                          ),
                                          leading: Icon(
                                            Icons.place,
                                            color: Colors.white,
                                          ),
                                        ),
                                      if (lugar.direccion != "")
                                        Divider(
                                          color: Colors.white,
                                        ),
                                      // ignore: unnecessary_null_comparison
                                      if (lugar.abierto != null)
                                        ListTile(
                                          title: Text(
                                            lugar.abierto
                                                ? "Abierto"
                                                : "Cerrado",
                                            style: TextStyle(
                                                fontFamily: "Poppins-Light",
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                          leading: Icon(
                                            Icons.watch_later_outlined,
                                            color: Colors.white,
                                          ),
                                        ),
                                      // ignore: unnecessary_null_comparison
                                      if (lugar.abierto != null)
                                        Divider(
                                          color: Colors.white,
                                        ),
                                      TextButton(
                                          onPressed: () async {
                                            showLoading(context);
                                            DetalleLugar detalle =
                                                new DetalleLugar();
                                            List<Map> parametros = [
                                              {"Id": lugar.id}
                                            ];
                                            detalle.construct(
                                                "Detalle", parametros);
                                            await detalle.llamarAPI();
                                            Navigator.of(context).pop();
                                            if (detalle.mostrar == true) {
                                              detalle.mostrarVista(context);
                                            } else {
                                              snackBarError(context,
                                                  "Lo sentimos, no se pudo procesar su solicitud");
                                            }
                                          },
                                          child: Text("Ver más detalles",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Colors.white))),
                                      Divider(
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: ElevatedButton(
                                              child: Text(
                                                "Ver viajes en Uber",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                  fixedSize:
                                                      Size.fromHeight(50),
                                                  primary: Colors.black),
                                              onPressed: () async {
                                                linkUberLugar(lugar);
                                              })),
                                      SizedBox(
                                        height: 30,
                                      ),
                                    ])));
                      });
                },
                backgroundColor: Colors.deepOrangeAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
              );
            }));
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
        rotateGesturesEnabled: true,
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
