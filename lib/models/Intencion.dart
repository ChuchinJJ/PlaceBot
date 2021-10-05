import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Intencion {
  late String tipo;
  late List<Map> parametros;
  late String respuesta;
  late bool mostrar;

  void construct(String tipo, List<Map> parametros) {
    this.tipo = tipo;
    this.parametros = parametros;
  }

  Widget vista();

  llamarAPI();

  mostrarVista(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: Text('PlaceBot', style: TextStyle(fontSize: 25)),
                    centerTitle: true,
                    toolbarHeight: 80,
                  ),
                  body: vista(),
                )));
  }
}
