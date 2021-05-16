import 'dart:math';

import 'package:contrify/Services/firebase_messaging.dart';
import 'package:contrify/StateManagement/app_state.dart';
import 'package:contrify/UI/Pages/landing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessagingHandler.initalize();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    AppState.instance.errorStream.listen((event) {
      show(event);
    });
  }

  void show(String event) {
    final context = navigatorKey.currentState?.overlay?.context;
    final dialog = AlertDialog(
      content: Text('$event'),
    );
    showDialog(context: context!, builder: (x) => dialog);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Contrify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(),
    );
  }
}
