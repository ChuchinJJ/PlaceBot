import 'package:flutter/material.dart';

class Aviso extends StatefulWidget {
  @override
  AvisoState createState() => AvisoState();
}

class AvisoState extends State<Aviso> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aviso de privacidad', style: TextStyle(fontSize: 25)),
        centerTitle: true,
        toolbarHeight: 80,
      ),
      body: ListView(children: <Widget>[
        Container(
            margin: new EdgeInsets.all(30),
            child: Column(children: <Widget>[
              Container(
                child: Text(
                  "Politica de privacidad de PlaceBot",
                  style: TextStyle(fontSize: 26, color: Colors.deepOrange),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                child: Text(
                  "Fecha que entra en efecto: 29 de septiembre de 2021",
                  style: TextStyle(fontSize: 17, color: Colors.deepOrange),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                child: Text(
                  "Esta política de seguridad gobierna el uso de la aplicación de software PlaceBot para dispositivos móviles que fue creada por ARMSoft, es una aplicación que permitie conversar con un chatbot para proporcionar información sobre destinos, rutas en un mapa",
                  style: TextStyle(fontSize: 20, color: Colors.deepOrange),
                  textAlign: TextAlign.justify,
                ),
              ),
            ]))
      ]),
    );
  }
}
