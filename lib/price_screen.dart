import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'network.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String btcPrice = '?';
  String ethPrice = '?';
  String ltcPrice = '?';
  String currencyPrice;

  DropdownButton<String> androidDropDown() {
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
        });
      },
    );
  }

  CupertinoPicker iOSDropDown() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (itemID) {
        setState(() {
          selectedCurrency = currenciesList[itemID];
        });
      },
      children: pickerItems,
    );
  }

  //this populate the children view in the column with items from cryptoCardView
  List<Text> textList(String cryptoPrice, String currency) {
    List<Text> list = [];
    for (var cryptoType in cryptoList) {
      if (cryptoType == 'BTC') {
        cryptoPrice = btcPrice;
      } else if (cryptoType == 'ETH') {
        cryptoPrice = ethPrice;
      } else {
        cryptoPrice = ltcPrice;
      }
      list.add(cryptoCardView(cryptoType, cryptoPrice, currency));
    }
    return list;
  }

  //This List the items in the column
  Text cryptoCardView(String cryptoType, String cryptoPrice, String currency) {
    return Text(
      '1 $cryptoType = $cryptoPrice $currency',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.white,
      ),
    );
    
  }

  //this method makes a call to the network.dart and get result from the
  //getCryptoData method and get the result of the rate from the return object.
  void getCryptoPrice() async {
    var getApiData = await NetworkAdapter().getCryptoData(selectedCurrency);
    var getETHData = await NetworkAdapter().getETHData(selectedCurrency);
    var getLTCData = await NetworkAdapter().getLTCData(selectedCurrency);
    setState(() {
      btcPrice = getApiData['rate'].toStringAsFixed(2);
      ethPrice = getETHData['rate'].toStringAsFixed(2);
      ltcPrice = getLTCData['rate'].toStringAsFixed(2);
    });
  }

  //this method executes as soon as you open the app
  @override
  void initState() {
    super.initState();
    getCryptoPrice();
  }

  //the build method executes anytime there is a change in th UI
  @override
  Widget build(BuildContext context) {
    getCryptoPrice();
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Crypto Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Column(
                  children: textList(currencyPrice, selectedCurrency),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            //child: Platform.isIOS ? iOSDropDown() : androidDropDown(),
            child: iOSDropDown(),
          ),
        ],
      ),
    );
  }
}
