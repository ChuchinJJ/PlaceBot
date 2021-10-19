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
