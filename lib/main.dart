import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:placebot/services/auth.dart';
import 'package:placebot/views/login.dart';
import 'package:placebot/views/tab.dart';
import 'package:placebot/widget/loading.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider<AuthService>(
      child: MyApp(),
      create: (_) => AuthService(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'PlaceBot',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          primaryColor: Colors.deepOrange[600],
        ),
        home: FutureBuilder<User?>(
          future: Provider.of<AuthService>(context).getUser(),
          builder: (context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.error != null) {
                print("error");
                Provider.of<AuthService>(context, listen: false).notifY();
                return Text(snapshot.error.toString());
              }
              return snapshot.hasData ? Tabs() : LoginPage();
            } else {
              return Loading();
            }
          },
        ));
  }
}
