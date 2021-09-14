import 'package:flutter/material.dart';

class Aviso extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aviso de privacidad', style: TextStyle(fontSize: 25)),
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
                    "Politica de privacidad de PlaceBot",
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  margin: new EdgeInsets.only(bottom: 20.0, top: 20.0),
                ),
                Container(
                  child: Text(
                    "Fecha que entra en efecto:/n 29 de Septiembre de 2021/n Esta politica de privacidad gobierna el\n uso de la aplicacion de software\n PlaceBot para dispositivos moviles\n que fue creada por ARMSoft\n es una aplicacion que permite conversar\n con un chatbot para proporcionar informacion\n sobre destinos, rutas en un mapa.\n Esta ploitica de seguridad\n describe como PlaceBot recopila\n utiliza y comunica sus datos personales\n atraves del servicio, y que opciones\n tiene con respectoa dichos datos...mas.",
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
