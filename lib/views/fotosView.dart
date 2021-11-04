import 'package:flutter/material.dart';
import 'package:placebot/services/googleMaps.dart';
import 'package:placebot/views/ImagePage.dart';

class FotosView extends StatefulWidget {
  final List<String> datos;
  FotosView(this.datos);
  @override
  FotosViewState createState() => FotosViewState(datos);
}

class FotosViewState extends State<FotosView> {
  final List<String> datos;
  FotosViewState(this.datos);
  List<GestureDetector> imagenes = [];

  @override
  Widget build(BuildContext context) {
    for (var referencia in datos) {
      imagenes.add(GestureDetector(
        child: Container(
          width: 20.0,
          height: 20.0,
          decoration: new BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                fotosLugar(referencia),
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ImagenPage(referencia)),
          );
        },
      ));
    }

    return GridView.count(
      primary: true,
      padding: const EdgeInsets.all(4),
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      crossAxisCount: 2,
      children: imagenes,
    );
  }
}
