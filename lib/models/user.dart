import 'package:firebase_auth/firebase_auth.dart';

class Usuario {
  User? user;

  static final Usuario _usuario = Usuario._internal();

  Usuario._internal();

  factory Usuario(User user) {
    _usuario.user = user;
    return _usuario;
  }

  static String getUid() {
    return _usuario.user!.uid;
  }

  static String? getNombre() {
    return _usuario.user!.displayName;
  }

  static String? getCorreo() {
    return _usuario.user!.email;
  }

  static String? getUrlImagen() {
    return _usuario.user!.photoURL;
  }
}
