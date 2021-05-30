import 'dart:convert';
import 'package:contrify/Models/Contract.dart';
import 'package:contrify/UI/Pages/contract_explorer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:contrify/Services/networking.dart' as networking;

class AppState {
  static final instance = AppState._();

  AppState._() {
    fetchAndParse();
    fetchData();
  }

  final navigatorKey = GlobalKey<NavigatorState>();

  final _dataSubject = BehaviorSubject<List<Contract>>();
  Stream<List<Contract>> get dataStream => _dataSubject.stream;
  Sink get _dataSink => _dataSubject.sink;

  final _statsSubject = PublishSubject();
  Stream get statsStream => _statsSubject.stream;
  Sink get _statsSink => _statsSubject.sink;

  int totalContracts = 0, faToken = 0, contractCalls = 0;

  void fetchData() async {
    final respose = await networking.getStats();
    if (respose.statusCode == 200) {
      final data = jsonDecode(respose.body);
      print(data);
      totalContracts = data['totalContracts'];
      faToken = data['faToken'];
      contractCalls = data['contractCalls'];
      _statsSink.add(0);
    } else {
      _showErrorDialog('Something Went Wrong, Check you Internet');
    }
  }

  Future<Contract?> searchAddress(String address) async {
    _showProgress();
    final response = await networking.getSearch(address);
    _dismissprogress();
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Contract.fromJson(data);
    } else if (response.statusCode == 404) {
      final data = jsonDecode(response.body);
      _showErrorDialog('$address ${data['message']}');
    } else {
      _showErrorDialog('Something Went Wrong, Check you Internet');
    }
    return null;
  }

  void fetchAndParse() async {
    final response = await networking.getContracts();
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      List<Contract> contracts = data.map((e) => Contract.fromJson(e)).toList();
      _dataSink.add(contracts);
    } else {
      _showErrorDialog('Something Went Wrong, Check you Internet');
    }
  }

  void dispose() {
    _dataSubject.close();
    _statsSubject.close();
  }

  void _showErrorDialog(String event) {
    final context = navigatorKey.currentState?.context;
    final dialog = AlertDialog(
      content: Text('$event'),
    );
    showDialog(context: context!, builder: (x) => dialog);
  }

  void _showProgress() {
    final context = navigatorKey.currentContext;
    final dialog = Center(child: Container(child: CircularProgressIndicator(),height: 100,width: 100,padding: EdgeInsets.all(20),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(10)),)));
    showDialog(
        context: context!, builder: (x) => dialog, barrierDismissible: false);
  }

  void _dismissprogress() {
      navigatorKey.currentState?.pop();
  }

  void handleFirebaseMessage() async {
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      _showProgress();
      Contract? c =
          await AppState.instance.searchAddress(message.data['address']);
      _dismissprogress();
      if (c != null) {
        navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => ContractExplore(c: c)));
      }
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      _showProgress();
      Contract? c =
          await AppState.instance.searchAddress(message.data['address']);
      _dismissprogress();
      if (c != null) {
        navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => ContractExplore(c: c)));
            fetchAndParse();
            fetchData();
      }
    });

    
  }
}
