import 'dart:convert'; // Required for jsonDecode
import 'package:http/http.dart' as http; // Required for the network request
import 'package:coin_tracker_challenge/models/coin_model.dart';

// Constants provided from the challenge instructions
const kAPIKey = 'CG-MLnmGSpv8PvZ7ubxswsVsDDe';
const kBaseURL = 'https://api.coingecko.com/api/v3';

const List<String> currenciesList = [
  'AUD', 'BRL', 'CAD', 'CNY', 'EUR', 'GBP', 'HKD', 'IDR', 'ILS', 'INR',
  'JPY', 'MXN', 'NOK', 'NZD', 'PLN', 'RON', 'RUB', 'SEK', 'SGD', 'USD', 'ZAR'
];

const List<String> cryptoList = [
  'BTC/Bitcoin',
  'ETH/Ethereum',
  'LTC/Litecoin',
];

class CoinData {

  // FIXED TODO: 1.0 Create a function of type Future<List<CoinModel>?>, called getCoinData, which takes a String parameter called currency
  Future<List<CoinModel>?> getCoinData(String currency) async {

    // FIXED TODO: 1.2 Create an empty List of type CoinModel called cryptoPrices
    List<CoinModel> cryptoPrices = [];

    // Convert target fiat currency lowercase as CoinGecko expects lowercase tracking formats (e.g., 'usd')
    String fiat = currency.toLowerCase();

    // FIXED TODO: 1.3 Use a For In loop that loops through the cryptoList
    for (String crypto in cryptoList) {

      // FIXED TODO: 1.3.6 Split optimization - get token ID and display name from layout 'BTC/Bitcoin'
      List<String> splitParts = crypto.split('/');
      String cryptoSymbol = splitParts[0]; // e.g., 'BTC'
      String cryptoId = splitParts[1].toLowerCase(); // e.g., 'bitcoin' (CoinGecko maps queries to lowercase names/ids)

      // Construct request URL referencing the simple price tracker endpoints
      // Including your specific unique API Key inside header metadata payload
      var url = Uri.parse('$kBaseURL/simple/price?ids=$cryptoId&vs_currencies=$fiat');

      try {
        // FIXED TODO: 1.3.3 Inside the loop make a request to the server
        http.Response response = await http.get(
          url,
          headers: {'x-cg-demo-api-key': kAPIKey},
        );

        // FIXED TODO: 1.3.4 Check if the status code of the response is 200, otherwise print the status code
        if (response.statusCode == 200) {

          // FIXED TODO: 1.3.5 Inside the IF block, decode the response to a JSON object
          var decodedData = jsonDecode(response.body);

          // Safely extract the calculated price. Map structure matches: { "bitcoin": { "usd": 63450.0 } }
          double price = decodedData[cryptoId][fiat]?.toDouble() ?? 0.0;

          // FIXED TODO: 1.3.6 Create a CoinModel object, assign split parts safely, then append to our tracking array list
          CoinModel coin = CoinModel(
            icon: cryptoSymbol, // Gives it the shorthand token code icon name ('BTC')
            name: splitParts[1], // Gives it the complete readable proper Coin Name ('Bitcoin')
            price: price, // Gives it the live exchange value calculated
          );

          cryptoPrices.add(coin);
        } else {
          print('Failed request: Server responded with status code ${response.statusCode}');
        }
      } catch (e) {
        print('Network execution failure inside loop block: $e');
      }
    }

    // FIXED TODO: 1.4 At the end of the function, after the loop, return the cryptoPrices array list
    return cryptoPrices;
  }
}