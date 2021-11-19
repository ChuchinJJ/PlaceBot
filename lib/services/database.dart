import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:placebot/models/Intencion.dart';

class DatabaseMethods {
  static addUser(uid, nombre, email) async {
    FirebaseFirestore.instance.collection("usuarios").doc(uid).set({
      'nombre': nombre,
      'email': email,
    }).catchError((e) {
      print(e.toString());
    });

    FirebaseFirestore.instance.collection("chats").add({
      "usuario": uid,
      "mensajes": [
        {
          "texto":
              "Hola yo soy Dasha, un asistente que te ayudará a trazar rutas, buscar algún lugar o establecimientos cercanos a ti, entre otras cosas",
          "fecha": DateTime.now(),
          "bot": true,
          "intencion": {"tipo": "Saludo", "parametros": []}
        },
        {
          "texto":
              "Puedes pedirme que busque un lugar por ti, intenta escribir “¿Dónde se encuentra Chichén Itzá?” o “Restaurantes cercanos”",
          "fecha": DateTime.now(),
          "bot": true,
          "intencion": {"tipo": "Saludo", "parametros": []}
        },
        {
          "texto":
              "Si no sabes que hacer pideme ayuda, simplemente escribe “Dasha ayudame”, y yo con gusto te atenderé o puedes ver la sección de ayuda",
          "fecha": DateTime.now(),
          "bot": true,
          "intencion": {"tipo": "Saludo", "parametros": []}
        }
      ]
    });
  }

  static searchUser(uid, nombre, email) async {
    FirebaseFirestore.instance
        .collection('usuarios')
        .doc(uid)
        .get()
        .then((value) => {
              if (value.data() == null) {addUser(uid, nombre, email)}
            })
        .catchError((e) {
      addUser(uid, nombre, email);
    });
  }

  static addMessage(String chatId, String message, bool bot) {
    FirebaseFirestore.instance.collection("chats").doc(chatId).update({
      "mensajes": FieldValue.arrayUnion([
        {"texto": message, "bot": bot, "fecha": DateTime.now()}
      ]),
    }).catchError((e) {
      print(e.toString());
    });
  }

  static addMessageBot(
      String chatId, String message, bool bot, Intencion intencion) {
    String tipo = intencion.tipo;
    var parametros = intencion.parametros;
    FirebaseFirestore.instance.collection("chats").doc(chatId).update({
      "mensajes": FieldValue.arrayUnion([
        {
          "texto": message,
          "bot": bot,
          "fecha": DateTime.now(),
          "intencion": {"tipo": tipo, "parametros": parametros}
        }
      ]),
    }).catchError((e) {
      print(e.toString());
    });
  }
}
