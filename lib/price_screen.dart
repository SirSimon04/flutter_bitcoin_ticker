import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(child: Text(currency), value: currency);
      dropDownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          btcValue = '?';
          ethValue = '?';
          ltcValue = '?';
          updateUI(selectedCurrency);
        });
      },
    );
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return iOSPicker();
    } else if (Platform.isAndroid) {
      return androidDropdown();
    }
  }

  CupertinoPicker iOSPicker() {
    List<Widget> dropDownItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(child: Text(currency), value: currency);
      dropDownItems.add(newItem);
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        selectedCurrency = currenciesList[selectedIndex];
        btcValue = '?';
        ethValue = '?';
        ltcValue = '?';
        updateUI(selectedCurrency);
      },
      children: dropDownItems,
    );
  }

  String btcValue = '?';
  String ethValue = '?';
  String ltcValue = '?';

  Future<void> updateUI(String currency) async {
    var data1 = await CoinData().getCoinData('BTC', currency);
    double recievedData1 = data1['rate'];

    var data2 = await CoinData().getCoinData('ETH', currency);
    double recievedData2 = data2['rate'];

    var data3 = await CoinData().getCoinData('LTC', currency);
    double recievedData3 = data3['rate'];
    setState(() {
      btcValue = recievedData1.toStringAsFixed(2);
      ethValue = recievedData2.toStringAsFixed(2);
      ltcValue = recievedData3.toStringAsFixed(2);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(selectedCurrency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CurrencyTile(
                  currencyValue: btcValue,
                  selectedCurrency: selectedCurrency,
                  selectedCrypto: 'BTC',
                ),
                CurrencyTile(
                  currencyValue: ethValue,
                  selectedCurrency: selectedCurrency,
                  selectedCrypto: 'ETH',
                ),
                CurrencyTile(
                  currencyValue: ltcValue,
                  selectedCurrency: selectedCurrency,
                  selectedCrypto: 'LTC',
                ),
              ]),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class CurrencyTile extends StatelessWidget {
  CurrencyTile(
      {this.currencyValue, this.selectedCurrency, this.selectedCrypto});

  final String currencyValue;
  final String selectedCurrency;
  final String selectedCrypto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $selectedCrypto = $currencyValue $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
