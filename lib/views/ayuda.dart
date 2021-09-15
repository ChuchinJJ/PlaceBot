import 'package:flutter/material.dart';

class Ayuda extends StatefulWidget {
  @override
  AyudaState createState() => AyudaState();
}

class AyudaState extends State<Ayuda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayuda', style: TextStyle(fontSize: 25)),
        centerTitle: true,
        toolbarHeight: 80,
      ),
      body: ListView(children: <Widget>[
        Container(
            margin: EdgeInsets.all(30),
            child: Column(children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Preguntas frecuentes",
                  style: TextStyle(fontSize: 26, color: Colors.deepOrange),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: 30.0),
              ExpansionTile(
                collapsedTextColor: Colors.deepOrange,
                collapsedIconColor: Colors.deepOrange,
                childrenPadding: EdgeInsets.only(bottom: 20),
                title: Text("¿Comó puedo solicitar una ruta?",
                    style: TextStyle(fontSize: 18)),
                children: [
                  Text(
                      "Para solicitar una ruta tiene que pedirle a Placy simplemente escribiendo, quiero ir de Acapulco a Jalisco",
                      style: TextStyle(fontSize: 16, color: Colors.deepOrange))
                ],
              ),
              ExpansionTile(
                collapsedTextColor: Colors.deepOrange,
                collapsedIconColor: Colors.deepOrange,
                childrenPadding: EdgeInsets.only(bottom: 20),
                title: Text("¿Comó puedo buscar un lugar?",
                    style: TextStyle(fontSize: 18)),
                children: [
                  Text(
                      "Para buscar un lugar puedes escribirle a placy, donde está Bellas Artes México",
                      style: TextStyle(fontSize: 16, color: Colors.deepOrange))
                ],
              ),
              ExpansionTile(
                collapsedTextColor: Colors.deepOrange,
                collapsedIconColor: Colors.deepOrange,
                childrenPadding: EdgeInsets.only(bottom: 20),
                title: Text("¿Comó hacer preguntas al chat?",
                    style: TextStyle(fontSize: 18)),
                children: [
                  Text(
                      "Puedes hacer distintos tipos de preguntas, como por ejemplo para solicitar una ruta a un lugar simplemente tienes que escribir",
                      style: TextStyle(fontSize: 16, color: Colors.deepOrange))
                ],
              )
            ]))
      ]),
    );
  }
}
