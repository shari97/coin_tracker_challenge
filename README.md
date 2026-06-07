 Coin Tracker
A Flutter mobile app that displays live cryptocurrency prices in a currency of your choice, powered by the CoinGecko API.

Features

Live prices for Bitcoin, Ethereum, and Litecoin
21 supported fiat currencies (USD, GBP, EUR, JPY, and more)
Platform-adaptive UI — CupertinoPicker on iOS, DropdownButton on Android
Prices update instantly whenever a new currency is selected


Tech stack
LayerTechnologyFrameworkFlutter (Dart)HTTP requestspackage:httpPrice dataCoinGecko API v3 (/simple/price)Number formattingpackage:intl

Project structure
lib/
├── main.dart              # App entry point, MaterialApp setup
├── models/
│   └── coin_model.dart    # CoinModel data class (icon, name, price)
├── utilities/
│   └── coin_data.dart     # CoinData class — API calls, constants
└── screens/
└── price_screen.dart  # Main UI — list, picker/dropdown, state

Getting started
Prerequisites

Flutter SDK installed and on your PATH
An Android emulator, iOS simulator, or physical device connected

Installation

Clone the repository and navigate into it:

bashgit clone <your-repo-url>
cd coin_tracker_challenge

Install dependencies:

bashflutter pub get

Run the app:

bashflutter run

API
Prices are fetched from the CoinGecko API. The app uses the demo-tier key included in coin_data.dart. To use your own key, replace the value of kAPIKey in that file.
dartconst kAPIKey = 'your-key-here';
const kBaseURL = 'https://api.coingecko.com/api/v3';
Endpoint used: GET /simple/price?ids={coin}&vs_currencies={currency}

Supported currencies
AUD, BRL, CAD, CNY, EUR, GBP, HKD, IDR, ILS, INR, JPY, MXN, NOK, NZD, PLN, RON, RUB, SEK, SGD, USD, ZAR

Supported cryptocurrencies
SymbolNameBTCBitcoinETHEthereumLTCLitecoin

Dependencies
Add these to your pubspec.yaml if not already present:
yamldependencies:
flutter:
sdk: flutter
http: ^1.2.0
intl: ^0.19.0

Notes

google-services.json is excluded from version control via .gitignore
The app uses dart:io Platform to detect iOS vs Android at runtime and render the appropriate currency picker