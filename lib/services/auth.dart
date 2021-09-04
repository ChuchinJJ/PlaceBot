import 'dart:async';
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  /*User? _userFromFirebaseUser(User user) {
    if (user != null) {
      //return User(uid: user.uid);
    } else {
      return null;
    }
  }*/

  isLogin() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  Future<User?> getUser() async {
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
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //User? user = result.user;
      //return _userFromFirebaseUser(user!);
      notifyListeners();
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
      print("registro metodo");
      await auth.signInWithEmailAndPassword(email: email, password: password);
      //User? user = result.user;
      //return _userFromFirebaseUser(user!);
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

      await FirebaseAuth.instance.signInWithCredential(credential);
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
}
