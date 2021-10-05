import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class BotMessage extends types.TextMessage {
  final String tipoIntencion;
  final List<Map> parametrosIntencion;

  BotMessage(autor, DateTime data, id, String text, this.tipoIntencion,
      this.parametrosIntencion)
      : super(author: autor, text: text, id: id);

  String getIntencion() {
    return tipoIntencion;
  }

  List<Map> getParametros() {
    return parametrosIntencion;
  }
}
