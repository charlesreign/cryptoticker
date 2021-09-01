import 'package:http/http.dart' as http;
import 'dart:convert';

//get the api key from coinapi.io
const apiKey = '';

class NetworkAdapter {
  Future <dynamic> getCryptoData(currency) async {
    String url = 'https://rest.coinapi.io/v1/exchangerate/BTC/$currency?apikey=$apiKey';
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future <dynamic> getETHData(currency) async {
    String url = 'https://rest.coinapi.io/v1/exchangerate/ETH/$currency?apikey=$apiKey';
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future <dynamic> getLTCData(currency) async {
    String url = 'https://rest.coinapi.io/v1/exchangerate/LTC/$currency?apikey=$apiKey';
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
