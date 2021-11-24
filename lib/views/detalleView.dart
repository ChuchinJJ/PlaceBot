import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:placebot/models/JsonMaps.dart';
import 'package:placebot/services/googleMaps.dart';
import 'package:placebot/views/ImagePage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DetalleView extends StatefulWidget {
  final JsonDetalle datos;
  DetalleView(this.datos);
  @override
  DetalleViewState createState() => DetalleViewState(datos);
}

class DetalleViewState extends State<DetalleView> {
  final JsonDetalle datos;
  DetalleViewState(this.datos);
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListView(children: [
      Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                datos.nombre,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 30,
                    fontFamily: 'Poppins-Medium'),
              ),
              SizedBox(height: 20.0),
              if (datos.direccion != "")
                ListTile(
                  title: Text(
                    datos.direccion,
                    style: TextStyle(
                        fontFamily: "Poppins-Light",
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  leading: Icon(
                    Icons.place,
                    color: Colors.deepOrange,
                  ),
                ),
              if (datos.direccion != "")
                Divider(
                  color: Colors.deepOrange,
                ),
              if (datos.telefono != "")
                ListTile(
                    title: Text(
                      datos.telefono,
                      style: TextStyle(
                          fontFamily: "Poppins-Light",
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    leading: Icon(
                      Icons.phone,
                      color: Colors.deepOrange,
                    ),
                    onTap: () => launch("tel:" + datos.telefono)),
              if (datos.telefono != "")
                Divider(
                  color: Colors.deepOrange,
                ),
              if (datos.web != "")
                ListTile(
                  title: InkWell(
                      child: Text(
                        datos.web,
                        style: TextStyle(
                            fontFamily: "Poppins-Light",
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500),
                      ),
                      onTap: () => launch(datos.web)),
                  leading: Icon(
                    Icons.public,
                    color: Colors.deepOrange,
                  ),
                ),
              if (datos.web != "")
                Divider(
                  color: Colors.deepOrange,
                ),
              // ignore: unnecessary_null_comparison
              if (datos.abierto != null)
                ListTile(
                  title: ExpansionTile(
                      tilePadding: EdgeInsets.all(0),
                      expandedAlignment: Alignment.topLeft,
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      collapsedIconColor: Colors.deepOrange,
                      title: Text(
                        datos.abierto.toString() == "true"
                            ? "Abierto"
                            : "Cerrado",
                        style: TextStyle(
                            fontFamily: "Poppins-Light",
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      children: datos.horarios
                          .map((item) => Text(
                                item,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16, fontFamily: "Poppins-Light"),
                              ))
                          .toList()),
                  leading: Icon(
                    Icons.watch_later_outlined,
                    color: Colors.deepOrange,
                  ),
                ),
              // ignore: unnecessary_null_comparison
              if (datos.abierto != null)
                Divider(
                  color: Colors.deepOrange,
                ),
              // ignore: unnecessary_null_comparison
              if (datos.rating != null)
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  child: RatingBarIndicator(
                    rating: datos.rating,
                    direction: Axis.horizontal,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.deepOrangeAccent,
                    ),
                    unratedColor: Color.fromRGBO(120, 30, 0, 100),
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  ),
                ),
              // ignore: unnecessary_null_comparison
              if (datos.rating != null && datos.votos != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Calificación: " + datos.rating.toString(),
                      style: TextStyle(
                          fontFamily: "Poppins-Light",
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      datos.votos.toString() + ' votos',
                      style: TextStyle(
                          fontFamily: "Poppins-Light",
                          color: Colors.black,
                          fontSize: 20,
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
                  color: Colors.deepOrange,
                ),
              if (datos.fotos.length != 0)
                CarouselSlider(
                  options: CarouselOptions(height: 250),
                  items: datos.fotos.map((i) {
                    return Builder(builder: (BuildContext context) {
                      return GestureDetector(
                        child: Container(
                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage(
                                  fotosLugar(i["photo_reference"])),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    ImagenPage(i["photo_reference"])),
                          );
                        },
                      );
                    });
                  }).toList(),
                ),
              if (datos.comentarios.length != 0)
                Container(
                  padding: EdgeInsets.only(top: 30),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Opiniones",
                    style: TextStyle(
                        fontFamily: "Poppins-Light",
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              if (datos.comentarios.length != 0)
                Column(
                  children: datos.comentarios
                      .map((item) => Container(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          item["profile_photo_url"]),
                                      radius: 20,
                                    ),
                                    SizedBox(width: 15.0),
                                    Expanded(
                                        child: Text(item["author_name"],
                                            style: TextStyle(
                                                fontFamily: "Poppins-Light",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500)))
                                  ],
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    RatingBarIndicator(
                                      rating: item["rating"].toDouble(),
                                      itemSize: 20,
                                      direction: Axis.horizontal,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.deepOrangeAccent,
                                      ),
                                      unratedColor:
                                          Color.fromRGBO(120, 30, 0, 100),
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 2.0),
                                    ),
                                    SizedBox(width: 15.0),
                                    Text(item["relative_time_description"],
                                        style: TextStyle(
                                            fontFamily: "Poppins-Light",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500))
                                  ],
                                ),
                                SizedBox(height: 10.0),
                                Text(item["text"],
                                    style: TextStyle(
                                        fontFamily: "Poppins-Light",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                          ))
                      .toList(),
                ),
            ],
          ))
    ]));
  }
}
