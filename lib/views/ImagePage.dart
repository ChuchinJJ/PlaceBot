import 'package:flutter/material.dart';
import 'package:placebot/services/googleMaps.dart';

class ImagenPage extends StatelessWidget {
  final String referencia;
  ImagenPage(this.referencia);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(child: Image.network(fotosLugar(referencia))),
    );
  }
}
