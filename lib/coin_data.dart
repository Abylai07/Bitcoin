import 'package:bitcoin_ticker/price_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];


const apiKey = 'C464772F-4661-431B-B28C-C1D7681B6781';
const apiURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future getCoinData({String selectCurrency}) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestUrl = '$apiURL/$crypto/$selectCurrency?apikey=$apiKey';

      var Url = Uri.parse(requestUrl);
      http.Response response = await http.get(Url);

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
