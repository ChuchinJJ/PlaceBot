import 'dart:async';
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> getUser() async {
    if (auth.currentUser != null) {
      auth.currentUser!.reload();
    }
    return auth.currentUser;
  }

  Future logout() async {
    var result = FirebaseAuth.instance.signOut();
    notifyListeners();
    return result;
  }

  Future createUser(
      {required String name,
      required String email,
      required String password}) async {
    try {
      var usuario = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      usuario.user!.updateDisplayName(name);
      usuario.user!.updatePhotoURL(
          "https://firebasestorage.googleapis.com/v0/b/aircloud-6885a.appspot.com/o/logo.png?alt=media&token=7f20ccd2-7af0-4f7e-8502-2929d366d369");
      usuario.user!.reload();
      auth.currentUser!.reload();
      notifyListeners();
      addUser(usuario.user!.uid, name, email);
      return "login";
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future loginWithEmail(
      {required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
      return "login";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  Future loginWithGoogle() async {
    try {
      final GoogleSignIn _googleSignIn = new GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      var usuario =
          await FirebaseAuth.instance.signInWithCredential(credential);
      searchUser(
          usuario.user!.uid, usuario.user!.displayName, usuario.user!.email);
      notifyListeners();
      return "login";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.code;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future resetPass(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return "send";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.code;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  addUser(uid, nombre, email) async {
    FirebaseFirestore.instance.collection("usuarios").doc(uid).set({
      'nombre': nombre,
      'email': email,
    }).catchError((e) {
      print(e.toString());
    });

    FirebaseFirestore.instance.collection("chats").add({
      "usuario": uid,
      "mensajes": [
        {
          "texto":
              "Hola yo soy PlaceBot, un bot que te ayudará a trazar rutas y buscar lugares",
          "fecha": DateTime.now().toString(),
          "bot": true
        }
      ]
    });
  }

  searchUser(uid, nombre, email) async {
    FirebaseFirestore.instance
        .collection('usuarios')
        .doc(uid)
        .get()
        .catchError((e) {
      addUser(uid, nombre, email);
    });
  }
}
