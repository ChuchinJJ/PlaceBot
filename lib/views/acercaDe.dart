import 'package:flutter/material.dart';

class AcercaDe extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca De', style: TextStyle(fontSize: 25)),
        centerTitle: true,
      ),
      backgroundColor: Colors.tealAccent,
      body: Container(
          margin: new EdgeInsets.only(top: 20.0, left: 20.0),
          alignment: Alignment.center,
          child: Row(children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  child: Text(
                    "Informacion General:",
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  margin: new EdgeInsets.only(bottom: 20.0, top: 20.0),
                ),
                Container(
                  child: Text(
                    "PlaceBot es una aplicacion que sirve para conservar con un chatbot,\n dicho chatbot te proporcionara informacion sobre lugares, rutas y destinos.\n Tu le puedes preguntar sobre un destino y el te mostrara en el mapa,\n le puedes pedir que trace una ruta a cualquier lugar\n o que te muestre los detalles de un lugar especifico.",
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  margin: new EdgeInsets.only(bottom: 20.0, top: 20.0),
                ),
                Container(
                  child: Text(
                    "Historia:",
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  margin: new EdgeInsets.only(bottom: 20.0, top: 20.0),
                ),
                Container(
                  child: Text(
                    "ARMSoft es una empresa creada en el ano 2021,/n esta formada por un equipo\n de programadores que desarrollan\n la primera version de PlaceBoten 2021,\n la idea surgio.",
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  margin: new EdgeInsets.only(bottom: 20.0, top: 20.0),
                ),
              ],
            )
          ])),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
