import 'package:flutter/material.dart';

snackBarError(BuildContext context, _message) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    padding: EdgeInsets.all(30),
    content: Text(
      _message,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 17, color: Colors.deepOrange),
    ),
    backgroundColor: Colors.white,
    duration: Duration(milliseconds: 3000),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
    ),
  ));
}
