import 'package:flutter_witai/flutter_witai.dart';

class WitMethods {
  static Future<String> respuestaWit(String texto) async {
    final wit = WitManager(
        utterance: texto,
        headers: "N5YW7R76VF3MITIA57MH5WQFSH27QRT3",
        params: "message");
    dynamic response = await wit.fetchLink();

    //aquí va la lógica de respuesta
    var intents = response["intents"];
    if (intents.length == 0) {
      return ("Lo siento, no entendí tu pregunta, puedes intentar de otra forma");
    } else if (intents[0]["confidence"] < 0.65) {
      return ("No estoy completamente seguro de lo que solicitas");
    } else {
      //cadena de la responsabilidad
      String intentName = intents[0]["name"];
      var entities = response["entities"].values;
      //var entities = response["entities"].values.first[0];
      for (var entidad in entities) {
        //print(entidad[0]);
        print(entidad[0]["name"] + ": " + entidad[0]["value"]);
      }
      return intentName;
    }
  }
}
