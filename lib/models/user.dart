import 'package:firebase_auth/firebase_auth.dart';

class Usuario {
  static late String uid;
  static late String? nombre;
  static late String? correo;
  static late String? urlImagen;

  static costruct(User user) {
    uid = user.uid;
    nombre = user.displayName;
    correo = user.email;
    urlImagen = user.photoURL;
  }

  static String getUid() {
    return uid;
  }

  static String? getNombre() {
    return nombre;
  }

  static String? getCorreo() {
    return correo;
  }

  static String? getUrlImagen() {
    return urlImagen;
  }
}
