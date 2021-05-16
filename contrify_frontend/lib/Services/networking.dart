import 'package:http/http.dart' as http;

final _baseUrl = 'http://anshit01.centralindia.cloudapp.azure.com:5101/v1/';

Future<http.Response> getContracts() {
  return http.get(
    Uri.parse(_baseUrl + 'contracts/unique'),
  );
}

// http://anshit01.centralindia.cloudapp.azure.com:5101/v1/stats
Future<http.Response> getStats() {
  return http.get(
    Uri.parse(_baseUrl + 'stats'),
  );
}

Future<http.Response> getSearch(String address) {
  return http.get(Uri.parse(_baseUrl + "contracts/search/" + address));
}
