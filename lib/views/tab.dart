import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:placebot/views/chat.dart';
import 'package:placebot/views/configuracion.dart';
import 'package:placebot/views/mapa.dart';

class Tabs extends StatefulWidget {
  @override
  _TabState createState() => _TabState();
}

class _TabState extends State<Tabs> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  //int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  /*void _toggleTab() {
    _tabIndex = _tabController.index + 1;
    _tabController.animateTo(_tabIndex);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            controller: _tabController,
            //indicatorColor: Color(Colors.white.value),
            tabs: [
              Tab(text: 'Chat', icon: Icon(Icons.message)),
              Tab(text: 'Mapa', icon: Icon(Icons.map)),
              Tab(text: 'Configuración', icon: Icon(Icons.settings)),
            ],
          ),
          title: Text('PlaceBot', style: TextStyle(fontSize: 25)),
          centerTitle: true,
        ),
        body: TabBarView(controller: _tabController, children: [
          Chats(),
          Mapa(),
          Configuracion(),
        ]));
  }
}
