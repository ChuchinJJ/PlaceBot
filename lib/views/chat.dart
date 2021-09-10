import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class Chats extends StatefulWidget {
  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chats> {
  List<types.Message> _messages = [];
  final _user = const types.User(
      id: '06c33e8b-e835-4736-80f4-63f44b66666c',
      firstName: "prueba",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/aircloud-6885a.appspot.com/o/logo.png?alt=media&token=7f20ccd2-7af0-4f7e-8502-2929d366d369");
  final _user2 = const types.User(
      id: '08c33e8b-e835-4736-80f4-63f44b66668c',
      firstName: "PlaceBot",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/aircloud-6885a.appspot.com/o/logo.png?alt=media&token=7f20ccd2-7af0-4f7e-8502-2929d366d369");
  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _addMessage2(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
    _handleSendPressed2("Lo siento no te entendí");
  }

  void _handleSendPressed2(String message) {
    final textMessage = types.TextMessage(
      author: _user2,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message,
    );

    _addMessage2(textMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _user,
        showUserAvatars: true,
        //showUserNames: true,
        theme: DefaultChatTheme(
          inputBackgroundColor: Colors.deepOrange,
          //onAttachmentPressed: _handleSendPressed2,
          primaryColor: Colors.blue,
          userAvatarTextStyle: TextStyle(),
          userAvatarNameColors: <Color>[Colors.white],
          sendButtonIcon: Icon(Icons.send, color: Colors.white),
        ),
      ),
    );
  }

  /*
  @override
  Widget build(BuildContext context) {
    
    List<types.Message> _messages = [];
    final _user = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c');

    void _loadMessages() async {
      final response = await rootBundle.loadString('assets/messages.json');
      final messages = (jsonDecode(response) as List)
          .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
          .toList();

      setState(() {
        _messages = messages;
      });
    }

    @override
    void initState() {
      super.initState();
      _loadMessages();
    }

    void _addMessage(types.Message message) {
      setState(() {
        _messages.insert(0, message);
      });
    }

    void _handleAtachmentPressed() {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SizedBox(
              height: 144,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      //_handleImageSelection();
                    },
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Photo'),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Cancel'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    void _handleImageSelection() async {
      /*final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      //source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: "2",
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }*/
    }

    void _handleMessageTap(types.Message message) async {
      if (message is types.FileMessage) {
        //await OpenFile.open(message.uri);
      }
    }

    void _handlePreviewDataFetched(
      types.TextMessage message,
      types.PreviewData previewData,
    ) {
      final index = _messages.indexWhere((element) => element.id == message.id);
      final updatedMessage =
          _messages[index].copyWith(previewData: previewData);

      WidgetsBinding.instance?.addPostFrameCallback((_) {
        setState(() {
          _messages[index] = updatedMessage;
        });
      });
    }

    void _handleSendPressed(types.PartialText message) {
      final textMessage = types.TextMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: "2",
        text: message.text,
      );

      _addMessage(textMessage);
    }

    return Chat(
      messages: _messages,
      onAttachmentPressed: _handleAtachmentPressed,
      onMessageTap: _handleMessageTap,
      onPreviewDataFetched: _handlePreviewDataFetched,
      onSendPressed: _handleSendPressed,
      user: _user,
    );
  }*/
}

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}
