import 'dart:convert';
import 'package:contrify/Models/Contract.dart';
import 'package:rxdart/rxdart.dart';
import 'package:contrify/Services/networking.dart' as networking;

class AppState {
  static final instance = AppState._();
  AppState._() {
    fetchAndParse();
    fetchData();
  }

  final _dataSubject = BehaviorSubject<List<Contract>>();
  Stream<List<Contract>> get dataStream => _dataSubject.stream;
  Sink get _dataSink => _dataSubject.sink;

  final _errorSubject = PublishSubject<String>();
  Stream<String> get errorStream => _errorSubject.stream;
  Sink get _errorSink => _errorSubject.sink;

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
      _errorSink.add('Something Went Wrong, Check you Internet');
    }
  }

  Future<Contract?> searchAddress(String address) async {
    final response = await networking.getSearch(address);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Contract.fromJson(data);
    } else if (response.statusCode == 404) {
      final data = jsonDecode(response.body);
      _errorSink.add('$address ${data['message']}');
    } else {
      _errorSink.add('Something Went Wrong, Check you Internet');
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
      _errorSink.add('Something Went Wrong, Check you Internet');
    }
  }

  void dispose() {
    _dataSubject.close();
    _errorSubject.close();
    _statsSubject.close();
  }
}
