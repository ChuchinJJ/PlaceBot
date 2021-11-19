import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: Image.asset("assets/logo.gif", height: 100),
        alignment: Alignment(0.0, 0.0),
      ),
    );
  }
}

void showLoading(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Loading();
    },
  );
}
