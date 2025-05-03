import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'ARS',
  'AUD',
  'BRL',
  'CAD',
  'CHF',
  'CLP',
  'CNY',
  'CZK',
  'DKK',
  'EUR',
  'GBP',
  'HKD',
  'HRK',
  'HUF',
  'INR',
  'ISK',
  'JPY',
  'KRW',
  'NGN',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'THB',
  'TRY',
  'TWD',
  'USD',
];

const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];

class CoinData {
  Future<String> getCoinData(String currency) async {
    var url = Uri.parse('https://blockchain.info/ticker');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var price = data[currency]['last'].toString();
      return price;
    } else {
      throw Exception('Failed to load coin data');
    }
  }
}
