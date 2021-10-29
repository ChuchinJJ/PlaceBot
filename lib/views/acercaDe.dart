import 'package:flutter/material.dart';

class AcercaDe extends StatefulWidget {
  @override
  AcercaState createState() => AcercaState();
}

class AcercaState extends State<AcercaDe> {
  late ScrollController scroll = ScrollController();
  double progreso = 0;

  @override
  void initState() {
    super.initState();

    scroll.addListener(() {
      setState(() {
        progreso =
            ((100 / scroll.position.maxScrollExtent) * scroll.offset) / 100;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Acerca De', style: TextStyle(fontSize: 25)),
          centerTitle: true,
          toolbarHeight: 80,
        ),
        body: Stack(children: [
          ListView(controller: scroll, children: <Widget>[
            Container(
                margin: EdgeInsets.all(30),
                child: Column(children: <Widget>[
                  Container(
                    height: 150,
                    child: Image.asset("assets/logoTitulo.png"),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Información General:",
                      style: TextStyle(
                          fontSize: 26, color: Colors.deepOrangeAccent),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "PlaceBot es una aplicación móvil que te permitirá solicitar información sobre lugares, rutas y destinos, mostrándolos en un mapa. Conoce a Dasha, nuestro Bot que te ayudará a buscar lugares y trazar rutas, puedes escribir alguna pregunta en el chat y Dasha con gusto te responderá a todas tus peticiones. Si no sabes que hacer, le puedes escribir \"Dasha ayúdame\".",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                        fontFamily: 'Poppins-Light'),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Historia:",
                      style: TextStyle(
                          fontSize: 26, color: Colors.deepOrangeAccent),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "ARMSoft es una empresa creada en el año 2021, está formada por un equipo de programadores que desarrollan la primera versión de PlaceBot en 2021, la idea surgió a partir de la evolución de la tecnología y la inteligencia artificial, y nosotros no nos queríamos quedar atrás, por eso se nos ocurrió la idea de integrar un ChatBot para la búsqueda de lugares en mapas, sería una manera recreativa y sencilla de usar para los usuarios.",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                        fontFamily: 'Poppins-Light'),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Misión:",
                      style: TextStyle(
                          fontSize: 26, color: Colors.deepOrangeAccent),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Llegar a ser una empresa reconocida a nivel mundial, usuarios de todo el mundo hagan uso de nuestra aplicación. Generar cada vez una mejor experiencia, buenas relaciones y obtener la mayor satisfacción de nuestros clientes. Creemos que debemos de innovar cada día para facilitar y mejorar nuestra atención y brindar un mejor servicio.",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                        fontFamily: 'Poppins-Light'),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Visión:",
                      style: TextStyle(
                          fontSize: 26, color: Colors.deepOrangeAccent),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Llegar a ser una empresa reconocida a nivel mundial, usuarios de todo el mundo hagan uso de nuestra aplicación. Generar cada vez una mejor experiencia, buenas relaciones y obtener la mayor satisfacción de nuestros clientes. Creemos que debemos de innovar cada día para facilitar y mejorar nuestra atención y brindar un mejor servicio.",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                        fontFamily: 'Poppins-Light'),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Valores:",
                      style: TextStyle(
                          fontSize: 26, color: Colors.deepOrangeAccent),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        String.fromCharCode(0x2022),
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.deepOrange,
                            height: 0.9),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                          child: Text("Transparencia",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: 'Poppins-Light',
                                  fontSize: 18))),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        String.fromCharCode(0x2022),
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.deepOrange,
                            height: 0.9),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                          child: Text("Excelencia",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: 'Poppins-Light',
                                  fontSize: 18))),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        String.fromCharCode(0x2022),
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.deepOrange,
                            height: 0.9),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                          child: Text("Libertad",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: 'Poppins-Light',
                                  fontSize: 18))),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        String.fromCharCode(0x2022),
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.deepOrange,
                            height: 0.9),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                          child: Text("Escucha",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: 'Poppins-Light',
                                  fontSize: 18))),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        String.fromCharCode(0x2022),
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.deepOrange,
                            height: 0.9),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                          child: Text("Responsabilidad",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: 'Poppins-Light',
                                  fontSize: 18))),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        String.fromCharCode(0x2022),
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.deepOrange,
                            height: 0.9),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                          child: Text("Pasión",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: 'Poppins-Light',
                                  fontSize: 18))),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        String.fromCharCode(0x2022),
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.deepOrange,
                            height: 0.9),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                          child: Text("Lealtad",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: 'Poppins-Light',
                                  fontSize: 18))),
                    ],
                  ),
                ]))
          ]),
          Positioned(
            top: 1,
            left: 0,
            right: 0,
            child: Container(
              child: LinearProgressIndicator(
                value: progreso,
              ),
            ),
          )
        ]));
  }
}
