import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:placebot/models/BotMessage.dart';
import 'package:placebot/models/Intencion.dart';
import 'package:placebot/models/user.dart';
import 'package:placebot/services/database.dart';
import 'package:placebot/services/wit.dart';
import 'package:placebot/widget/loading.dart';

class Chats extends StatefulWidget {
  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chats> {
  late String chatId;
  List<types.Message> _messages = [];
  String? nombreUsuario = Usuario.getNombre();
  String? uidUsuario = Usuario.getUid();

  @override
  Widget build(BuildContext context) {
    final _user =
        types.User(id: uidUsuario.toString(), firstName: nombreUsuario);
    final _bot = types.User(
        id: 'placebot',
        firstName: "PlaceBot",
        imageUrl:
            "https://firebasestorage.googleapis.com/v0/b/aircloud-6885a.appspot.com/o/logo.png?alt=media&token=7f20ccd2-7af0-4f7e-8502-2929d366d369");

    void _handleSendPressedBot(String message, Intencion intencion) {
      final textMessage = BotMessage(_bot, DateTime.now(), randomString(),
          message, intencion.tipo, intencion.parametros);

      DatabaseMethods.addMessageBot(chatId, message, true, intencion);
      _addMessage(textMessage);
    }

    void _handleSendPressed(types.PartialText message) {
      final textMessage = types.TextMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        text: message.text,
      );
      DatabaseMethods.addMessage(chatId, message.text, false);
      _addMessage(textMessage);
      WitMethods.respuestaWit(message.text, _handleSendPressedBot, context);
    }

    void _messageTap(message) {
      Intencion intencion = WitMethods.fabrica(
          message.tipoIntencion, message.parametrosIntencion, context);
      if (intencion.mostrar) {
        intencion.mostrarVista(context);
      }
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("chats")
          .where("usuario", isEqualTo: uidUsuario)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Algo salió mal');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        } else if (_messages.length == 0) {
          for (var mensajes in snapshot.data!.docs.last["mensajes"]) {
            if (mensajes["bot"]) {
              List<Map> parametros = [];

              for (var entidad in mensajes["intencion"]["parametros"]) {
                parametros.add(entidad);
              }
              _messages.insert(
                0,
                BotMessage(
                    _bot,
                    DateTime(mensajes["fecha"].millisecondsSinceEpoch),
                    randomString(),
                    mensajes["texto"].toString(),
                    mensajes["intencion"]["tipo"],
                    parametros),
              );
            } else {
              _messages.insert(
                0,
                types.TextMessage(
                    author: _user,
                    createdAt: mensajes["fecha"].millisecondsSinceEpoch,
                    id: randomString(),
                    text: mensajes["texto"].toString()),
              );
            }
          }
          chatId = snapshot.data!.docs.last.id;
        }

        return Scaffold(
          body: Chat(
            messages: _messages,
            onSendPressed: _handleSendPressed,
            user: _user,
            l10n: ChatL10nEs(
                inputPlaceholder: "Escribe un mensaje",
                emptyChatPlaceholder: "No hay ningun mensaje"),
            showUserAvatars: true,
            onMessageTap: _messageTap,
            customDateHeaderText: (a) => "",
            theme: DefaultChatTheme(
              inputBackgroundColor: Colors.deepOrange,
              primaryColor: Colors.blue,
              sendButtonIcon: Icon(Icons.send, color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }
}

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}
