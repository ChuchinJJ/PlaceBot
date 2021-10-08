import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:placebot/views/chat.dart';
import 'package:placebot/views/configuracion.dart';

class Menu extends StatefulWidget {
  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PlaceBot', style: TextStyle(fontSize: 25)),
          centerTitle: true,
          toolbarHeight: 60,
        ),
        drawer: Configuracion(),
        body: Chats());
  }
}
