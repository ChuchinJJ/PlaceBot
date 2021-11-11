import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:placebot/models/DetalleLugar.dart';
import 'package:placebot/models/JsonMaps.dart';
import 'package:placebot/models/Ruta.dart';
import 'package:placebot/services/googleMaps.dart';
import 'package:placebot/services/uberMethods.dart';

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
                                        datos.lugar,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontFamily: "Poppins-Medium"),
                                      ),
                                      // ignore: unnecessary_null_comparison
                                      if (datos.rating != null)
                                        Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(
                                              bottom: 10, top: 20),
                                          child: RatingBarIndicator(
                                            rating: datos.rating,
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
                                      if (datos.rating != null &&
                                          // ignore: unnecessary_null_comparison
                                          datos.votos != null)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "Calificación: " +
                                                  datos.rating.toString(),
                                              style: TextStyle(
                                                  fontFamily: "Poppins-Light",
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              datos.votos.toString() + ' votos',
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
                                      if (datos.rating != null)
                                        Divider(
                                          color: Colors.white,
                                        ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      if (datos.fotoUrl != "")
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              fotosLugar(datos.fotoUrl),
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
                                                  Ruta ruta = new Ruta();
                                                  List<Map> parametros = [
                                                    {
                                                      "Destino": datos.lat
                                                              .toString() +
                                                          "," +
                                                          datos.long.toString()
                                                    }
                                                  ];
                                                  ruta.construct(
                                                      "Ruta", parametros);
                                                  await ruta.llamarAPI();
                                                  ruta.mostrarVista(context);
                                                })
                                          ]),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Divider(
                                        color: Colors.white,
                                      ),
                                      if (datos.direccion != "")
                                        ListTile(
                                          title: Text(
                                            datos.direccion,
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
                                      if (datos.direccion != "")
                                        Divider(
                                          color: Colors.white,
                                        ),
                                      // ignore: unnecessary_null_comparison
                                      if (datos.abierto != null)
                                        ListTile(
                                          title: Text(
                                            datos.abierto
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
                                      if (datos.abierto != null)
                                        Divider(
                                          color: Colors.white,
                                        ),
                                      TextButton(
                                          onPressed: () async {
                                            DetalleLugar detalle =
                                                new DetalleLugar();
                                            List<Map> parametros = [
                                              {"Id": datos.id}
                                            ];
                                            detalle.construct(
                                                "Detalle", parametros);
                                            await detalle.llamarAPI();
                                            detalle.mostrarVista(context);
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
                                                linkUberLugar(datos);
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
