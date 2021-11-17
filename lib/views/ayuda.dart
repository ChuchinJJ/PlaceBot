import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:url_launcher/url_launcher.dart';

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
                collapsedTextColor: Colors.deepOrangeAccent,
                collapsedIconColor: Colors.deepOrangeAccent,
                childrenPadding: EdgeInsets.only(bottom: 20),
                title: Text("¿Cómo hacer preguntas al chat?",
                    style: TextStyle(fontSize: 18)),
                children: [
                  Text(
                      "Hacer una pregunta es muy fácil, es como usar cualquier app de mensajería, solo debes ubicarte en la parte inferior de tu pantalla, junto al icono de enviar, y empezar a escribir las búsquedas y solicitar lo que desees. Dasha contestará a todas tus peticiones al instante. Las búsquedas realizadas por el usuario se irán almacenando, al solicitar alguna ruta o la buscar algún lugar, Dasha enviará un mensaje indicando que la solicitud fue procesada, puedes presionar el mensaje para volver a abrir la solicitud.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black54,
                          fontFamily: "Poppins-Light"))
                ],
              ),
              SizedBox(height: 15),
              ExpansionTile(
                collapsedTextColor: Colors.deepOrangeAccent,
                collapsedIconColor: Colors.deepOrangeAccent,
                childrenPadding: EdgeInsets.only(bottom: 20),
                title: Text("¿Qué preguntas puedo hacer?",
                    style: TextStyle(fontSize: 18)),
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Buscar lugares:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins-Light")),
                  ),
                  Text(
                      "Puedes solicitar información de restaurantes, museos, cines, centros comerciales, hospitales, bancos, bares, gimnasios, aeropuertos, escuelas, o cualquier lugar que desees buscar y se mostrará su ubicación en un mapa.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black54,
                          fontFamily: "Poppins-Light")),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Trazar ruta:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins-Light")),
                  ),
                  Text(
                      "Puedes pedir que se te muestren rutas de un lugar a otro, o de tu posición a otro lugar, se mostrará la ruta en un mapa y aparecerá el tiempo y la distancia del recorrido.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black54,
                          fontFamily: "Poppins-Light")),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Buscar lugares cercanos:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins-Light")),
                  ),
                  Text(
                      "Puedes además ver los establecimientos cercanos a tu ubicación tales como restaurantes, hospitales, hoteles, parques, cafeterías, farmacias entre muchos otros.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black54,
                          fontFamily: "Poppins-Light")),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Detalles de un lugar:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins-Light")),
                  ),
                  Text(
                      "Puedes solicitar que se te muestren los detalles de un lugar, incluye la dirección completa del lugar, número de teléfono, página web, horarios, valoración, fotografías, y algunas reseñas de los usuarios (dependiendo del lugar algunos datos pueden no aparecer).",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black54,
                          fontFamily: "Poppins-Light")),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Fotos de un lugar:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins-Light")),
                  ),
                  Text(
                      "Puedes pedir que se te muestren las fotografías de un lugar.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black54,
                          fontFamily: "Poppins-Light")),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Solicitar Uber:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins-Light")),
                  ),
                  Text(
                      "Puedes pedir que se te muestren viajes en Uber a algún destino, para usar esta opción es necesario tener instalada la aplicación de Uber.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black54,
                          fontFamily: "Poppins-Light")),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              SizedBox(height: 15),
              ExpansionTile(
                collapsedTextColor: Colors.deepOrangeAccent,
                collapsedIconColor: Colors.deepOrangeAccent,
                childrenPadding: EdgeInsets.only(bottom: 20),
                title: Text("¿Cómo puedo solicitar una ruta?",
                    style: TextStyle(fontSize: 18)),
                children: [
                  Text(
                      " Debes escribir en el chat la ruta a la que quieres ir, puedes especificar un origen y el destino, por ejemplo: “Trazar una ruta de Chiapas a Oaxaca” o “Marca una ruta de Playa Portal Maya a Chichén Itzá”. Si deseas que el origen sea tu posición actual, entonces no especifiques ningún origen y solo indica el destino, por ejemplo “Muéstrame una ruta a Puerto Vallarta” o “Crea una ruta a Zoológico Yumka”. Después aparecerá un mapa con la ruta trazada.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black54,
                          fontFamily: "Poppins-Light"))
                ],
              ),
              SizedBox(height: 15),
              ExpansionTile(
                collapsedTextColor: Colors.deepOrangeAccent,
                collapsedIconColor: Colors.deepOrangeAccent,
                childrenPadding: EdgeInsets.only(bottom: 20),
                title: Text("¿Cómo puedo buscar un lugar?",
                    style: TextStyle(fontSize: 18)),
                children: [
                  Text(
                      "Debes escribir en el chat la pregunta acerca del lugar del cual quieres obtener información, por ejemplo: “¿Dónde está Six flags México?”, “Donde se encuentra el Palacio de Bellas Artes” o “Donde se hallan las Cascadas de Agua Azul”. Después aparecerá un mapa con el lugar marcado, al presionar sobre el marcador se mostrará una pequeña información sobre el lugar.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black54,
                          fontFamily: "Poppins-Light"))
                ],
              ),
              SizedBox(height: 15),
              ExpansionTile(
                collapsedTextColor: Colors.deepOrangeAccent,
                collapsedIconColor: Colors.deepOrangeAccent,
                childrenPadding: EdgeInsets.only(bottom: 20),
                title: Text("¿Cómo puedo buscar lugares cercanos?",
                    style: TextStyle(fontSize: 18)),
                children: [
                  Text(
                      "Debes escribir en el chat el tipo de establecimiento que deseas buscar, por ejemplo: “Restaurantes cercanos”, “Hospitales a mi alrededor” o “Parques alrededor de mí”. Después aparecerá un mapa con marcadores de los lugares encontrados, al presionar sobre el marcador se mostrará una pequeña información sobre el lugar.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black54,
                          fontFamily: "Poppins-Light"))
                ],
              ),
              SizedBox(height: 15),
              ExpansionTile(
                collapsedTextColor: Colors.deepOrangeAccent,
                collapsedIconColor: Colors.deepOrangeAccent,
                childrenPadding: EdgeInsets.only(bottom: 20),
                title: Text("¿Cómo puedo buscar los detalles de un lugar?",
                    style: TextStyle(fontSize: 18)),
                children: [
                  Text(
                      "Debes escribir en el chat una pregunta solicitando los detalles de un lugar, por ejemplo: “Detalles del Museo de las momias Guanajuato” y se mostrará una vista con los datos del lugar como: dirección completa del lugar, número de teléfono, página web, horarios, valoración, fotografías, y algunas reseñas de los usuarios. Dependiendo del lugar buscado algunos datos pueden no mostrarse.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black54,
                          fontFamily: "Poppins-Light"))
                ],
              ),
              SizedBox(height: 15),
              ExpansionTile(
                collapsedTextColor: Colors.deepOrangeAccent,
                collapsedIconColor: Colors.deepOrangeAccent,
                childrenPadding: EdgeInsets.only(bottom: 20),
                title: Text("¿Cómo puedo buscar las fotos de un lugar?",
                    style: TextStyle(fontSize: 18)),
                children: [
                  Text(
                      "Debes escribir en el chat una pregunta solicitando las fotos de un lugar, por ejemplo: “Fotos del Museo de las momias Guanajuato” y se mostrará una vista con las fotos del lugar, puedes presionar sobre alguna foto para que se muestre la fotografía completa.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black54,
                          fontFamily: "Poppins-Light"))
                ],
              ),
              SizedBox(height: 15),
              ExpansionTile(
                collapsedTextColor: Colors.deepOrangeAccent,
                collapsedIconColor: Colors.deepOrangeAccent,
                childrenPadding: EdgeInsets.only(bottom: 20),
                title: Text("¿Cómo puedo solicitar un viaje en Uber?",
                    style: TextStyle(fontSize: 18)),
                children: [
                  Text(
                      "Debes escribir en el chat una pregunta solicitando el viaje en Uber e indicando tu destino, por ejemplo: “Viaje en Uber al Museo de las momias Guanajuato” o “Solicitar Uber al Palacio de Bellas Artes” y se abrirá la app de Uber en donde aparecerán los viajes que puedes seleccionar.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black54,
                          fontFamily: "Poppins-Light"))
                ],
              ),
              SizedBox(height: 15),
              ExpansionTile(
                collapsedTextColor: Colors.deepOrangeAccent,
                collapsedIconColor: Colors.deepOrangeAccent,
                childrenPadding: EdgeInsets.only(bottom: 20),
                title: Text("He buscado una ruta, pero no aparece, ¿Qué hacer?",
                    style: TextStyle(fontSize: 18)),
                children: [
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      text:
                          'La razón por la cual la ruta no aparece puede ser porque estas escribiendo la pregunta de forma incorrecta puedes pedirle ayuda a Dasha si no sabes cómo hacerlo, verifica también que estas escribiendo correctamente el nombre del lugar/es, Si todo está correcto y aun no puedes ver tu respuesta verifica que tu ubicación este activada y que le hallas dado los permisos a la aplicación para hacer uso de tu ubicación. Si sigues sin poder ver tu respuesta puedes ',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                          fontFamily: "Poppins-Light"),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'contactarnos',
                          style: TextStyle(
                              color: Colors.deepOrangeAccent,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launch(
                                  "mailto:josedejesuscons@gmail.com?subject=PlaceBot");
                            },
                        ),
                        TextSpan(
                          text: " para atender a tus dudas.",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                              fontFamily: "Poppins-Light"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              ExpansionTile(
                collapsedTextColor: Colors.deepOrangeAccent,
                collapsedIconColor: Colors.deepOrangeAccent,
                childrenPadding: EdgeInsets.only(bottom: 20),
                title: Text(
                    "La aplicación me pide permisos para acceder a mi ubicación",
                    style: TextStyle(fontSize: 18)),
                children: [
                  Text(
                      "Para poder brindarle un mejor y certero servicio prescindimos de la ubicación de su dispositivo, y es necesario que le conceda los permisos necesarios a la aplicación, dependiendo de su sistema operativo le aparecerá una ventana emergente para activar los permisos, puede ser que le aparezca una ventana en donde muestre todas sus aplicaciones, debe de encontrar PlaceBot y habilitar el permiso de Ubicación.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black54,
                          fontFamily: "Poppins-Light"))
                ],
              ),
              SizedBox(height: 15),
              ExpansionTile(
                collapsedTextColor: Colors.deepOrangeAccent,
                collapsedIconColor: Colors.deepOrangeAccent,
                childrenPadding: EdgeInsets.only(bottom: 20),
                title: Text("Dasha responde que no me entendió",
                    style: TextStyle(fontSize: 18)),
                children: [
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      text:
                          'En algunas ocasiones puede suceder que Dasha no comprenda lo que le preguntes, en esos casos contestará con un mensaje diciendo “Lo siento no te entendí, prueba de otra forma”, probablemente suceda cuando estes escribiendo mal las preguntas o tratando de charlar de una manera no destinada para la aplicación; puedes ver esta sección o pedirle ayuda a Dasha si no sabes cómo hacer las preguntas. Seguiremos trabajando para darte cada vez un mejor servicio, puedes enviarnos tus comentarios a nuestro ',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                          fontFamily: "Poppins-Light"),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'correo de contacto',
                          style: TextStyle(
                              color: Colors.deepOrangeAccent,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launch(
                                  "mailto:josedejesuscons@gmail.com?subject=PlaceBot");
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              ExpansionTile(
                collapsedTextColor: Colors.deepOrangeAccent,
                collapsedIconColor: Colors.deepOrangeAccent,
                childrenPadding: EdgeInsets.only(bottom: 20),
                title: Text(
                    "¿Qué información puedo encontrar al hacer una búsqueda?",
                    style: TextStyle(fontSize: 18)),
                children: [
                  Text(
                      "Si la búsqueda es sobre alguna ruta la información puede incluir es la distancia, duración (dependiendo de la forma que elijas desplazarte), puedes seleccionar el modo de viaje en Automóvil, caminando o en bicicleta.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black54,
                          fontFamily: "Poppins-Light")),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "Si la búsqueda es de un lugar puede incluir dirección, una foto, calificación de los usuarios, la opción para trazar la ruta o para pedir un Uber.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black54,
                          fontFamily: "Poppins-Light")),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "Todo lo anterior será mostrado a través de un mapa, el cual podrás elegir de qué manera observar: Normal, Satélite y Terreno. ",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black54,
                          fontFamily: "Poppins-Light")),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ]))
      ]),
    );
  }
}
