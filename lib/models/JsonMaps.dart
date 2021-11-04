class JsonLugar {
  final String id;
  final String lugar;
  final double lat;
  final double long;
  final String direccion;
  final String fotoUrl;
  final double rating;
  final String status;
  final List<dynamic> types;
  final bool abierto;
  final int votos;

  JsonLugar(
      {required this.id,
      required this.lugar,
      required this.lat,
      required this.long,
      required this.direccion,
      required this.fotoUrl,
      required this.rating,
      required this.status,
      required this.types,
      required this.abierto,
      required this.votos});

  factory JsonLugar.fromJson(Map<String, dynamic> json) {
    return JsonLugar(
        id: json["place_id"] != null ? json["place_id"] : "",
        lugar: json["name"] != null ? json["name"] : "",
        lat: json["geometry"]["location"]["lat"],
        long: json["geometry"]["location"]["lng"],
        direccion:
            json["formatted_address"] != null ? json["formatted_address"] : "",
        fotoUrl:
            json["photos"] != null ? json["photos"][0]["photo_reference"] : "",
        rating: json["rating"] != null ? json["rating"].toDouble() : null,
        status: json["business_status"] != null ? json["business_status"] : "",
        types: json["types"] != null ? json["types"] : [],
        abierto: json["opening_hours"] != null
            ? json["opening_hours"]["open_now"]
            : null,
        votos: json["user_ratings_total"] != null
            ? json["user_ratings_total"]
            : null);
  }
}

class JsonRuta {
  final String origen;
  final double latOrigen;
  final double longOrigen;
  final String destino;
  final double latDestino;
  final double longDestino;
  final String distancia;
  final String duracion;
  final Map noreste;
  final Map suroeste;

  JsonRuta(
      {required this.origen,
      required this.latOrigen,
      required this.longOrigen,
      required this.destino,
      required this.latDestino,
      required this.longDestino,
      required this.distancia,
      required this.duracion,
      required this.noreste,
      required this.suroeste});

  factory JsonRuta.fromJson(Map<String, dynamic> json) {
    return JsonRuta(
        origen: json["legs"][0]["start_address"],
        latOrigen: json["legs"][0]["start_location"]["lat"],
        longOrigen: json["legs"][0]["start_location"]["lng"],
        destino: json["legs"][0]["end_address"],
        latDestino: json["legs"][0]["end_location"]["lat"],
        longDestino: json["legs"][0]["end_location"]["lng"],
        distancia: json["legs"][0]["distance"]["text"],
        duracion: json["legs"][0]["duration"]["text"],
        noreste: json["bounds"]["northeast"],
        suroeste: json["bounds"]["southwest"]);
  }
}

class JsonDetalle {
  final String id;
  final String nombre;
  final String direccion;
  final String telefono;
  final List<dynamic> fotos;
  final double rating;
  final String status;
  final List<dynamic> types;
  final List<dynamic> comentarios;
  final bool abierto;
  final List<dynamic> horarios;
  final String web;
  final int votos;

  JsonDetalle(
      {required this.id,
      required this.nombre,
      required this.direccion,
      required this.telefono,
      required this.fotos,
      required this.rating,
      required this.status,
      required this.types,
      required this.comentarios,
      required this.abierto,
      required this.horarios,
      required this.web,
      required this.votos});

  factory JsonDetalle.fromJson(Map<String, dynamic> json) {
    return JsonDetalle(
        id: json["place_id"] != null ? json["place_id"] : "",
        nombre: json["name"] != null ? json["name"] : "",
        direccion: json["vicinity"] != null
            ? json["vicinity"]
            : json["formatted_address"],
        telefono: json["formatted_phone_number"] != null
            ? json["formatted_phone_number"]
            : "",
        fotos: json["photos"] != null ? json["photos"] : [],
        rating: json["rating"] != null ? json["rating"].toDouble() : null,
        status: json["business_status"] != null ? json["business_status"] : "",
        types: json["types"] != null ? json["types"] : [],
        comentarios: json["reviews"] != null ? json["reviews"] : [],
        abierto: json["opening_hours"] != null
            ? json["opening_hours"]["open_now"]
            : null,
        horarios: json["opening_hours"] != null
            ? json["opening_hours"]["weekday_text"]
            : [],
        web: json["website"] != null ? json["website"] : "",
        votos: json["user_ratings_total"] != null
            ? json["user_ratings_total"]
            : null);
  }
}
