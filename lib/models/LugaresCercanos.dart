import 'package:flutter/material.dart';
import 'package:placebot/models/Intencion.dart';
import 'package:placebot/models/JsonMaps.dart';
import 'package:placebot/services/googleMaps.dart';
import 'package:placebot/views/lugaresCercanosView.dart';

class LugaresCercanos extends Intencion {
  late String busqueda;
  static late List<JsonLugar> datos = [];

  @override
  llamarAPI() async {
    try {
      busqueda = parametros[0]["TipoLugar"].toLowerCase();
      String tipoLugar = "";
      if (tiposAdmitidos.containsKey(busqueda)) {
        tiposAdmitidos.forEach((key, value) async {
          if (key == busqueda) {
            tipoLugar = value;
          }
        });
        await buscarTipoLugar(tipoLugar).then((valor) {
          if (valor == "Sin_resultados") {
            mostrar = false;
            respuesta = "Lo sentimos, no se encontraron coincidencias";
          } else {
            for (var lugar in valor) {
              datos.add(JsonLugar.fromJson(lugar));
            }
            respuesta = busqueda + " encontrados";
            mostrar = true;
          }
        });
      } else {
        await buscarLugaresTexto(busqueda).then((valor) {
          if (valor == "Sin_resultados") {
            mostrar = false;
            respuesta = "Lo sentimos, no se encontraron coincidencias";
          } else {
            for (var lugar in valor) {
              datos.add(JsonLugar.fromJson(lugar));
            }
            respuesta = busqueda + " encontrados";
            mostrar = true;
          }
        });
      }
    } catch (e) {
      print(e);
      mostrar = false;
      respuesta = "Lo sentimos ocurrió un error, intenta de otra forma";
    }
  }

  @override
  Widget vista() {
    return LugaresCercanosView(datos);
  }
}

Map<String, String> tiposAdmitidos = {
  "acuarios": "aquarium",
  "acuario": "aquarium",
  "galerias de arte": "art_gallery",
  "galeria de arte": "art_gallery",
  "galerías de arte": "art_gallery",
  "galería de arte": "art_gallery",
  "aeropuertos": "airport",
  "aeropuerto": "airport",
  "parque de atracciones": "amusement_park",
  "atracciones": "amusement_park",
  "parque de atracción": "amusement_park",
  "atracción": "amusement_park",
  "cajeros automáticos": "atm",
  "cajeros automaticos": "atm",
  "cajeros automático": "atm",
  "cajeros automatico": "atm",
  "panaderías": "bakery",
  "panaderias": "bakery",
  "panadería": "bakery",
  "panaderia": "bakery",
  "banco": "bank",
  "bancos": "bank",
  "bar": "bar",
  "bares": "bar",
  "libreria": "book_store",
  "librerias": "book_store",
  "librería": "book_store",
  "librerías": "book_store",
  "estación de autobuses": "bus_station",
  "estacion de autobuses": "bus_station",
  "autobuses": "bus_station",
  "autobus": "bus_station",
  "cafeterias": "coffee_shop",
  "cafeteria": "coffee_shop",
  "cafeterías": "coffee_shop",
  "cafetería": "coffee_shop",
  "lavado de coches": "car_wash",
  "lavados de coches": "car_wash",
  "casino": "casino",
  "casinos": "casino",
  "iglesia": "church",
  "Iglesias": "church",
  "dentista": "dentist",
  "dentistas": "dentist",
  "doctor": "doctor",
  "doctores": "doctor",
  "farmacia": "drugstore",
  "farmacias": "drugstore",
  "gimnasio": "gym",
  "gimnasios": "gym",
  "gym": "gym",
  "hospital": "hospital",
  "hospitales": "hospital",
  "joyería": "insurance_agency",
  "joyerías": "insurance_agency",
  "joyeria": "insurance_agency",
  "joyerias": "insurance_agency",
  "lavandería": "jewelry_store",
  "lavanderías": "jewelry_store",
  "lavanderia": "jewelry_store",
  "lavanderias": "jewelry_store",
  "alojamiento": "lodging",
  "alojamientos": "lodging",
  "comida para llevar": "meal_takeaway",
  "cine": "movie_theater",
  "cines": "movie_theater",
  "museo": "museum",
  "museos": "museum",
  "club nocturno": "night_club",
  "club nocturnos": "night_club",
  "clubs nocturnos": "night_club",
  "parque": "park",
  "parques": "park",
  "estacionamiento": "parking",
  "estacionamientos": "parking",
  "restaurantes": "restaurant",
  "restaurante": "restaurant",
  "restaurant": "restaurant",
  "restaurants": "restaurant",
  "supermercado": "supermarket",
  "supermercados": "supermarket",
  "parada de taxi": "taxi_stand",
  "parada de taxis": "taxi_stand",
  "taxi": "taxi_stand",
  "taxis": "taxi_stand",
  "atracción turística": "tourist_attraction",
  "turismo": "tourist_attraction",
  "agencia de viajes": "travel_agency",
  "agencias de viajes": "travel_agency",
  "salón de belleza": "beauty_salon",
  "salon de belleza": "beauty_salon",
  "salones de belleza": "beauty_salon",
  "alquiler de coches": "car_rental",
  "alquileres de coches": "car_rental",
  "reparación de autos": "car_repair",
  "reparacion de autos": "car_repair",
  "mecánico": "car_repair",
  "mecánicos": "car_repair",
  "mecanico": "car_repair",
  "mecanicos": "car_repair",
  "cementerio": "cemetery",
  "cementerios": "cemetery",
  "tienda de ropa": "clothing_store",
  "tiendas de ropa": "clothing_store",
  "tienda de departamentos": "department_store",
  "departamentos": "department_store",
  "departamento": "department_store",
  "electricista": "electrician",
  "electricistas": "electrician",
  "electricísta": "electrician",
  "electricístas": "electrician",
  "tienda de electrónicos": "electronics_store",
  "tiendas de electrónicos": "electronics_store",
  "tienda de electronicos": "electronics_store",
  "tiendas de electronicos": "electronics_store",
  "electronicos": "electronics_store",
  "electrónicos": "electronics_store",
  "estación de bomberos": "fire_station",
  "estaciones de bomberos": "fire_station",
  "bomberos": "fire_station",
  "florería": "florist",
  "florerías": "florist",
  "floreria": "florist",
  "florerias": "florist",
  "casa funeraria": "funeral_home",
  "funeraria": "funeral_home",
  "funerarias": "funeral_home",
  "casa funeraría": "funeral_home",
  "funeraría": "funeral_home",
  "funerarías": "funeral_home",
  "tienda de muebles": "furniture_store",
  "tiendas de muebles": "furniture_store",
  "muebles": "furniture_store",
  "gasolinera": "gas_station",
  "gasolineras": "gas_station",
  "gasolinería": "gas_station",
  "gasolinerías": "gas_station",
  "ferretería": "hardware_store",
  "ferreterías": "hardware_store",
  "ferreteria": "hardware_store",
  "ferreterias": "hardware_store",
  "agencia de seguros": "insurance_agency",
  "agencias de seguros": "insurance_agency",
  "seguros": "insurance_agency",
  "abogado": "lawyer",
  "abogados": "lawyer",
  "biblioteca": "library",
  "bibliotecas": "library",
  "tienda de licores": "liquor_store",
  "licores": "liquor_store",
  "cerrajero": "locksmith",
  "cerrajeros": "locksmith",
  "empresa de mudanzas": "moving_company",
  "tienda de mascotas": "pet_store",
  "tiendas de mascotas": "pet_store",
  "mascotas": "pet_store",
  "fisioterapeuta": "physiotherapist",
  "fisioterapeutas": "physiotherapist",
  "plomero": "plumber",
  "plomeros": "plumber",
  "policia": "police",
  "policias": "police",
  "policía": "police",
  "policías": "police",
  "oficina de correos": "post_office",
  "correos": "post_office",
  "escuela primaria": "primary_school",
  "escuelas primarias": "primary_school",
  "colegio": "school",
  "colegios": "school",
  "escuela": "school",
  "escuelas": "school",
  "escuela secundaria": "secondary_school",
  "escuelas secundaria": "secondary_school",
  "zapatería": "shoe_store",
  "zapateria": "shoe_store",
  "zapaterías": "shoe_store",
  "zapaterias": "shoe_store",
  "spa": "spa",
  "estadio": "stadium",
  "estadios": "stadium",
  "almacenamiento": "storage",
  "almacenamientos": "storage",
  "tienda": "store",
  "tiendas": "store",
  "estación de metro": "subway_station",
  "estacion de metro": "subway_station",
  "estaciones de metro": "subway_station",
  "metro": "subway_station",
  "estación de tren": "train_station",
  "estación de trenes": "train_station",
  "estaciones de trenes": "train_station",
  "tren": "train_station",
  "trenes": "train_station",
  "univerisidad": "university",
  "univerisidades": "university",
  "veterinario": "veterinary_care",
  "veterinarios": "veterinary_care",
  "veterinaria": "veterinary_care",
  "veterinarias": "veterinary_care",
  "zoologico": "zoo",
  "zoologicos": "zoos",
  "zoológico": "zoo",
  "zoológicos": "zoo",
};
