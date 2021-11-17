import 'package:flutter/material.dart';
import 'package:placebot/models/user.dart';
import 'package:placebot/services/auth.dart';
import 'package:placebot/views/acercaDe.dart';
import 'package:placebot/views/aviso.dart';
import 'package:placebot/views/ayuda.dart';
import 'package:placebot/views/terminosUso.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Configuracion extends StatefulWidget {
  @override
  ConfiguracionState createState() => ConfiguracionState();
}

class ConfiguracionState extends State<Configuracion> {
  String? nombre = Usuario.getNombre();
  String? email = Usuario.getCorreo();
  String? imagen = Usuario.getUrlImagen();
  late Widget ima;

  @override
  Widget build(BuildContext contexto) {
    if (imagen == null) {
      ima = Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.deepOrange,
          ),
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: 55,
          ));
    } else {
      ima = CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage(imagen.toString()),
        backgroundColor: Colors.transparent,
      );
    }
    return Drawer(
      child: Stack(
        children: [
          ListView(children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                nombre.toString(),
                style: TextStyle(fontSize: 17),
              ),
              accountEmail:
                  Text(email.toString(), style: TextStyle(fontSize: 16)),
              currentAccountPicture: ima,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                        Colors.black38,
                        BlendMode.darken,
                      ),
                      image: AssetImage("assets/fondo_ruta.jpg"),
                      fit: BoxFit.cover)),
            ),
            SizedBox(height: 20.0),
            ListTile(
              onTap: () {
                Navigator.push(
                  contexto,
                  MaterialPageRoute(builder: (context) => AcercaDe()),
                );
              },
              title: Text("Acerca de",
                  style:
                      TextStyle(color: Colors.deepOrangeAccent, fontSize: 16)),
              leading: Icon(
                Icons.info_outline,
                color: Colors.deepOrangeAccent,
              ),
            ),
            SizedBox(height: 5.0),
            ListTile(
              onTap: () {
                Navigator.push(
                  contexto,
                  MaterialPageRoute(builder: (context) => Ayuda()),
                );
              },
              title: Text("Ayuda",
                  style:
                      TextStyle(color: Colors.deepOrangeAccent, fontSize: 16)),
              leading: Icon(
                Icons.help_outline,
                color: Colors.deepOrangeAccent,
              ),
            ),
            SizedBox(height: 5.0),
            ListTile(
              onTap: () {
                launch("mailto:josedejesuscons@gmail.com?subject=PlaceBot");
              },
              title: Text("Contacto",
                  style:
                      TextStyle(color: Colors.deepOrangeAccent, fontSize: 16)),
              leading: Icon(
                Icons.email_outlined,
                color: Colors.deepOrangeAccent,
              ),
            ),
            SizedBox(height: 5.0),
            ListTile(
              onTap: () {
                Navigator.push(
                  contexto,
                  MaterialPageRoute(builder: (context) => Aviso()),
                );
              },
              title: Text("Aviso de privacidad",
                  style:
                      TextStyle(color: Colors.deepOrangeAccent, fontSize: 16)),
              leading: Icon(
                Icons.remove_red_eye_outlined,
                color: Colors.deepOrangeAccent,
              ),
            ),
            SizedBox(height: 5.0),
            ListTile(
              onTap: () {
                Navigator.push(
                  contexto,
                  MaterialPageRoute(builder: (context) => Terminos()),
                );
              },
              title: Text("Términos de uso",
                  style:
                      TextStyle(color: Colors.deepOrangeAccent, fontSize: 16)),
              leading: Icon(
                Icons.lock_outline,
                color: Colors.deepOrangeAccent,
              ),
            ),
            SizedBox(height: 5.0),
            ListTile(
              onTap: () async {
                try {
                  var result =
                      await Provider.of<AuthService>(contexto, listen: false)
                          .logout();
                  print(result);
                } catch (e) {
                  print(e.toString());
                }
              },
              title: Text("Cerrar sesión",
                  style:
                      TextStyle(color: Colors.deepOrangeAccent, fontSize: 16)),
              leading: Icon(
                Icons.logout,
                color: Colors.deepOrangeAccent,
              ),
            ),
          ]),
          Positioned(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              right: 1,
              left: 1,
              child: Container(
                padding: EdgeInsets.only(bottom: 15),
                child: Text(
                  "Versión 1.0 ARMSoft",
                  style: TextStyle(color: Colors.deepOrange),
                  textAlign: TextAlign.center,
                ),
              ))
        ],
      ),
    );
  }
}
