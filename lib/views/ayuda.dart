import 'package:flutter/material.dart';

class Ayuda extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayuda', style: TextStyle(fontSize: 25)),
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
                    "Preguntas Frecuentes",
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  margin: new EdgeInsets.only(bottom: 20.0, top: 20.0),
                ),
              ],
            ),
            ListView(children: [
              _buildItem('Como puedo solicitar una ruta?'),
              _buildItem('Como puedo buscar un lugar?'),
              _buildItem('Como hacer preguntas en el chat?'),
              _buildItem('Como solicitar una ruta para Uber?')
            ]),
          ])),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

Widget _buildItem(String textTitle) {
  return new ListTile(
    title: new Text(textTitle),
    subtitle: new Text('Ver mas'),
    leading: new Icon(Icons.map),
  );
}
