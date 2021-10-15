import 'package:http/http.dart' as http;
import 'dart:convert';

String key = "AIzaSyBh6-q7wJ8FWjMt-mTSgxGSEHwwPFYBK1Y";

buscarLugar(String ubicacion) async {
  final response = await http.get(Uri.parse(
      'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=' +
          ubicacion +
          '&inputtype=textquery&key=' +
          key +
          '&fields=formatted_address,geometry,name,photo,place_id,type'));
  if (response.statusCode == 200) {
    if (jsonDecode(response.body)["status"] == "OK") {
      var valor = jsonDecode(response.body)["candidates"][0];
      return valor;
    }
    return "Sin_resultados";
  } else {
    throw Exception('Failed to load');
  }
}
