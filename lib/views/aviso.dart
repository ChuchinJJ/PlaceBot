import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Aviso extends StatefulWidget {
  @override
  AvisoState createState() => AvisoState();
}

class AvisoState extends State<Aviso> {
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
          title: Text('Aviso de privacidad', style: TextStyle(fontSize: 25)),
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
                        "Politica de privacidad de PlaceBot",
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.deepOrange,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        "Se les comunica, de conformidad con lo previsto por la Ley Federal de Protección de Datos Personales en Posesión de los Particulares, así como el Reglamento de la Ley Federal de Protección de Datos Personales en Posesión de Terceros, en armonía con los Lineamientos del Aviso de Privacidad publicados en el Diario Oficial de la Federación de fecha 17 de Enero de 2013, al que refiere el Artículo 43 de la Ley Federal de Protección de Datos Personales en Posesión de Particulares, que PlaceBot pone a su disposición el presente Aviso de Privacidad Integral, con la finalidad de proteger sus datos en los términos que la Ley y el Reglamento disponen para tales efectos.",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black54,
                            fontFamily: 'Poppins-Light'),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 20.0),
                      RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          text: '',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                              fontFamily: 'Poppins-Light'),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Fecha que entra en efecto: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: ' 29 de septiembre de 2021'),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        "El presente Aviso de Privacidad establece los términos en que ARMSoft usa y protege la información que es proporcionada por sus usuarios al momento de utilizar su aplicación móvil PlaceBot. Esta compañía está comprometida con la seguridad de los datos de sus usuarios. Cuando le pedimos llenar los campos de información personal con la cual usted pueda ser identificado, lo hacemos asegurando que sólo se empleará de acuerdo con los términos de este documento. Sin embargo este Aviso de Privacidad puede cambiar con el tiempo o ser actualizada por lo que le recomendamos y enfatizamos revisar continuamente este apartado para asegurarse que está de acuerdo con dichos cambios.",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black54,
                            fontFamily: 'Poppins-Light'),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 60.0),
                      Text(
                        "Información que es recogida",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.deepOrange,
                            fontFamily: 'Poppins-Medium'),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        "Nuestra aplicación móvil podrá recoger información personal por ejemplo: Nombre de usuario, información de contacto como  su dirección de correo electrónica, una contraseña. Así mismo cuando sea necesario podrá ser requerida la ubicación específica para poder brindar mejor precisión en las búsquedas.",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black54,
                            fontFamily: 'Poppins-Light'),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        "ARMSoft está altamente comprometido para cumplir con el compromiso de mantener su información segura. Usamos los sistemas más avanzados y los actualizamos constantemente para asegurarnos que no exista ningún acceso no autorizado.",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black54,
                            fontFamily: 'Poppins-Light'),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 60.0),
                      Text(
                        "Uso de la información recogida",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.deepOrange,
                            fontFamily: 'Poppins-Medium'),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        "Nuestra aplicación móvil emplea la información con el fin de proporcionar el mejor servicio posible, particularmente para mantener un registro de usuarios, un historial de búsquedas, y mejorar la precisión de las búsquedas.",
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
                                  "Hacemos uso de su ubicación actual para poder realizar búsquedas de lugares cercanos su posición, al igual para trazar rutas hacia distintos lugares; para poder brindarle un servicio de mejor precisión.",
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
                                  "Todas sus conversaciones son almacenadas, esto con el único y exclusivo fin de que usted pueda ver el historial de sus mensajes y poder visualizar las búsquedas realizadas anteriormente.",
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
                                  "Usamos su correo electrónico para poder generar una cuenta en la aplicación, o en su caso para la recuperación de contraseñas a través de la misma aplicación móvil, estos correos electrónicos serán enviados a la dirección que usted proporcione y podrán ser cancelados en cualquier momento.",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'Poppins-Light',
                                      fontSize: 16))),
                        ],
                      ),
                      SizedBox(height: 60.0),
                      Text(
                        "Control de su información personal",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.deepOrange,
                            fontFamily: 'Poppins-Medium'),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        "En cualquier momento usted puede restringir la recopilación o el uso de la información personal que es proporcionada a nuestra aplicación móvil.  Cada vez que se le solicite rellenar un formulario, como el de alta de usuario, puede seleccionar la opción de registrarse con una cuenta existente de Google. En caso de que haya marcado la opción de darse de alta con una la cuenta de Google va a recibir un correo electrónico de confirmación usted es responsable de el registro de las dos opciones.",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black54,
                            fontFamily: 'Poppins-Light'),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Esta compañía no venderá, cederá ni distribuirá la información personal que es recopilada sin su consentimiento, salvo que sea requerido por un juez con un orden judicial. ARMSoft Se reserva el derecho de cambiar los términos del presente Aviso de Privacidad en cualquier momento.",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black54,
                            fontFamily: 'Poppins-Light'),
                        textAlign: TextAlign.justify,
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
