import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:placebot/views/aviso.dart';

class Terminos extends StatefulWidget {
  @override
  TerminosState createState() => TerminosState();
}

class TerminosState extends State<Terminos> {
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
          title: Text('Términos de servicio', style: TextStyle(fontSize: 25)),
          centerTitle: true,
          toolbarHeight: 80,
        ),
        body: Stack(children: [
          ListView(controller: scroll, children: <Widget>[
            Container(
                margin: new EdgeInsets.all(30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Términos y condiciones de uso",
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.deepOrange,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        "Esta aplicación móvil es propiedad y está operado por ARMSoft. Estos Términos establecen los términos y condiciones bajo los cuales tú puedes usar nuestra aplicación móvil y servicios ofrecidos por nosotros. Esta aplicación móvil ofrece a los usuarios solicitar rutas, buscar algún destino, ver los establecimientos cercanos (hoteles, restaurantes, parques, etc.). Las peticiones y búsquedas se harán mediante un chat, en el que los usuarios interactuarán con un Bot, el cual les responderá a sus peticiones. Al acceder o usar la app móvil de nuestro servicio, usted aprueba que haya leído, entendido y aceptado estar sujeto a estos Términos:",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black54,
                            fontFamily: 'Poppins-Light'),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            String.fromCharCode(0x2022),
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.deepOrange,
                                height: 0.8),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                              child: Text(
                                  "Para usar nuestra aplicación Móvil PlaceBot y/o recibir nuestros servicios, debes tener al menos 12 años de edad, y poseer la autoridad legal, el derecho y la libertad para participar en estos Términos como un acuerdo vinculante. No tienes permitido utilizar esta aplicación Móvil y/o recibir servicios si hacerlo está prohibido en tu país o en virtud de cualquier ley o regulación aplicable a tu caso.",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'Poppins-Light',
                                      fontSize: 16))),
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
                                height: 0.8),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                              child: Text(
                                  "Al crear una cuenta en PlaceBot, aceptas que:  Eres responsable de leer el listado completo del artículo antes de comprometerte a ser un usuario de esta aplicación.",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'Poppins-Light',
                                      fontSize: 16))),
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
                                height: 0.8),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                              child: Text(
                                  "Podemos, sin aviso previo, cambiar los servicios; dejar de proporcionar los servicios o cualquier característica de los servicios que ofrecemos; o crear límites para los servicios. Podemos  suspender de manera permanente o temporal el acceso a los servicios sin previo aviso ni responsabilidad por cualquier motivo, o sin ningún motivo.",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'Poppins-Light',
                                      fontSize: 16))),
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
                                height: 0.8),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                              child: Text(
                                  "El Servicio y todos los materiales incluidos o transferidos, incluyendo, sin limitación, software, imágenes, texto, gráficos, logotipos, patentes, marcas registradas, marcas de servicio, derechos de autor, fotografías, audio, videos, música y todos los Derechos de Propiedad Intelectual relacionados con ellos, son la propiedad exclusiva de ARMSoft. Salvo que se indique explícitamente en este documento, no se considerará que nada en estos Términos crea una licencia en o bajo ninguno de dichos Derechos de Propiedad Intelectual, y tu aceptas no vender, licenciar, alquilar, modificar, distribuir, copiar, reproducir, transmitir, exhibir públicamente, realizar públicamente, publicar, adaptar, editar o crear trabajos derivados de los mismos.",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'Poppins-Light',
                                      fontSize: 16))),
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
                                height: 0.8),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                              child: Text(
                                  "Podemos terminar o suspender de manera permanente o temporal tu acceso a tu cuenta en PlaceBot sin previo aviso y responsabilidad por cualquier razón, incluso si a nuestra sola determinación tu violas alguna disposición de estos Términos o cualquier ley o regulación aplicable. Puedes descontinuar el uso y solicitar cancelar tu cuenta y/o cualquier servicio en cualquier momento. ",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'Poppins-Light',
                                      fontSize: 16))),
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
                                height: 0.8),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                              child: Text(
                                  "En la máxima medida permitida por la ley aplicable, en ningún caso ARMSoft será responsable por daños indirectos, punitivos, incidentales, especiales, consecuentes o ejemplares, incluidos, entre otros, daños por pérdida de beneficios, buena voluntad, uso, datos. U otras pérdidas intangibles, que surjan de o estén relacionadas con el uso o la imposibilidad de utilizar el servicio.",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'Poppins-Light',
                                      fontSize: 16))),
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
                                height: 0.8),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                              child: Text(
                                  "En la máxima medida permitida por la ley aplicable, ARMSoft no asume responsabilidad alguna por errores, o inexactitudes de contenido; lesiones personales o daños a la propiedad, de cualquier naturaleza que sean, como resultado de tu acceso o uso de nuestra aplicación móvil; y cualquier acceso no autorizado o uso de nuestros servidores seguros y/o toda la información personal almacenada en los mismos.",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'Poppins-Light',
                                      fontSize: 16))),
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
                                height: 0.8),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                              child: Text(
                                  "Nos reservamos el derecho de modificar estos términos de vez en cuando a nuestra entera discreción. Por lo tanto, debes revisar este apartado periódicamente. Cuando cambiemos los Términos de una manera material, te notificaremos que se han realizado cambios importantes en los Términos. El uso continuado de PlaceBot después de dicho cambio constituye tu aceptación de los nuevos Términos. Si no aceptas alguno de estos términos o cualquier versión futura de los Términos, no uses o  accedas (o continúes accediendo) a la aplicación Móvil.",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'Poppins-Light',
                                      fontSize: 16))),
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
                                height: 0.8),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                              child: Text(
                                  "Estos Términos, los derechos y recursos provistos aquí, y todos y cada uno de los reclamos y disputas relacionados con este y/o los servicios, se regirán, interpretarán y aplicarán en todos los aspectos única y exclusivamente de conformidad con las leyes sustantivas internas de México, sin respeto a sus principios de conflicto de leyes. Todos los reclamos y disputas se presentarán y usted acepta que sean decididos exclusivamente por un tribunal de jurisdicción competente ubicada en Tuxtla Gutiérrez.",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'Poppins-Light',
                                      fontSize: 16))),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          text:
                              'Para conocer mayor información sobre los términos y condiciones en que serán tratados sus datos personales, como los terceros con quienes compartimos su información personal y la forma en que podrá ejercer sus derechos, puede consultar las ',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                              fontFamily: 'Poppins-Light'),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Políticas de privacidad',
                              style: TextStyle(color: Colors.deepOrange),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Aviso()),
                                  );
                                },
                            ),
                            TextSpan(text: ".")
                          ],
                        ),
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
