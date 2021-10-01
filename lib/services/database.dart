import 'package:cloud_firestore/cloud_firestore.dart';

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
              "Hola yo soy PlaceBot, un bot que te ayudará a trazar rutas y buscar lugares",
          "fecha": DateTime.now(),
          "bot": true
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
}
