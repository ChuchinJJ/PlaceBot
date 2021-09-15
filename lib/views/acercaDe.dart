import 'package:flutter/material.dart';

class AcercaDe extends StatefulWidget {
  @override
  AcercaState createState() => AcercaState();
}

class AcercaState extends State<AcercaDe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca De', style: TextStyle(fontSize: 25)),
        centerTitle: true,
        toolbarHeight: 80,
      ),
      body: ListView(children: <Widget>[
        Container(
            margin: new EdgeInsets.all(30),
            child: Column(children: <Widget>[
              Container(
                height: 200,
                child: Image.asset("assets/logoTitulo.png"),
              ),
              SizedBox(height: 30.0),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Informacion General:",
                  style: TextStyle(fontSize: 26, color: Colors.deepOrange),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                child: Text(
                  "PlaceBot es una aplicacion que sirve para conservar con un chatbot, dicho chatbot te proporcionara informacion sobre lugares, rutas y destinos. Tu le puedes preguntar sobre un destino y el te mostrara en el mapa, le puedes pedir que trace una ruta a cualquier lugar o que te muestre los detalles de un lugar especifico.",
                  style: TextStyle(fontSize: 20, color: Colors.deepOrange),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: 30.0),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Historia:",
                  style: TextStyle(fontSize: 26, color: Colors.deepOrange),
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                child: Text(
                  "ARMSoft es una empresa creada en el año 2021, esta formada por un equipo de programadores que desarrollan la primera versión de PlaceBot en 2021, la idea surgio.",
                  style: TextStyle(fontSize: 20, color: Colors.deepOrange),
                  textAlign: TextAlign.justify,
                ),
              ),
            ]))
      ]),
    );
  }
}
