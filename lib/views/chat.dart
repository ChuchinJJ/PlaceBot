import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:placebot/services/auth.dart';
import 'package:placebot/services/database.dart';
import 'package:placebot/services/wit.dart';
import 'package:placebot/widget/loading.dart';
import 'package:provider/provider.dart';

class PageChat extends StatelessWidget {
  @override
  Widget build(BuildContext contexto) {
    return Container(
      child: FutureBuilder<User?>(
        future: Provider.of<AuthService>(contexto).getUser(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.error != null) {
              print("error");
              return Text(snapshot.error.toString());
            }
            return Chats(snapshot.data);
          }
          return Loading();
        },
      ),
    );
  }
}

class Chats extends StatefulWidget {
  final User? currentUser;
  Chats(this.currentUser);
  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chats> {
  late String chatId;
  List<types.Message> _messages = [];

  @override
  Widget build(BuildContext context) {
    final _user = types.User(
        id: "${widget.currentUser!.uid}",
        firstName: "${widget.currentUser!.displayName}");
    final _bot = types.User(
        id: 'placebot',
        firstName: "PlaceBot",
        imageUrl:
            "https://firebasestorage.googleapis.com/v0/b/aircloud-6885a.appspot.com/o/logo.png?alt=media&token=7f20ccd2-7af0-4f7e-8502-2929d366d369");

    void _handleSendPressedBot(String message) {
      final textMessage = types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        text: message,
      );

      DatabaseMethods.addMessage(chatId, message, true);
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
      WitMethods.respuestaWit(message.text)
          .then((value) => _handleSendPressedBot(value));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("chats")
          .where("usuario", isEqualTo: "${widget.currentUser!.uid}")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Algo salió mal');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        } else if (_messages.length == 0) {
          for (var mensajes in snapshot.data!.docs.last["mensajes"]) {
            if (mensajes["bot"]) {
              _messages.insert(
                0,
                types.TextMessage(
                    author: _bot,
                    createdAt: DateTime.now().millisecondsSinceEpoch,
                    id: randomString(),
                    text: mensajes["texto"].toString()),
              );
            } else {
              _messages.insert(
                0,
                types.TextMessage(
                    author: _user,
                    createdAt: DateTime.now().millisecondsSinceEpoch,
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
