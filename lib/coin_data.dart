import 'networking.dart';

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

//http://rest.coinapi.io/v1/exchangerate/BTC/EUR?apikey=

const coinApiUrl = 'https://rest.coinapi.io/v1/exchangerate/';
const apiKey = 'DD59E872-532A-4936-B88D-4DE5882D5F4D';

class CoinData {
  Future<dynamic> getCoinData(String coin, String currency) async {
    NetworkHelper networkhelper =
        NetworkHelper('$coinApiUrl$coin/$currency?apikey=$apiKey');
    var coinData = await networkhelper.getData();
    print('got json');
    return coinData;
  }
}
