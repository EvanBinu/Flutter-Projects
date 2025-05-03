import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'coin.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PriceScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDark;

  PriceScreen({required this.onThemeChanged, required this.isDark});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String bitcoinPrice = '?';

  void getBTCPrice() async {
    try {
      CoinData coinData = CoinData();
      String price = await coinData.getCoinData(selectedCurrency);
      setState(() {
        bitcoinPrice = price;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getBTCPrice();
  }

  DropdownButton<String> androidDropdown() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items:
          currenciesList.map((String currency) {
            return DropdownMenuItem<String>(
              value: currency,
              child: Text(currency),
            );
          }).toList(),
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
        });
        getBTCPrice();
      },
    );
  }

  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
        });
        getBTCPrice();
      },
      children: currenciesList.map((c) => Text(c)).toList(),
    );
  }

  Widget getPicker() {
    if (kIsWeb || Platform.isAndroid) return androidDropdown();
    if (Platform.isIOS) return iOSPicker();
    return androidDropdown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(FontAwesomeIcons.bitcoin, color: Colors.orange, size: 30),
            SizedBox(width: 10),
            Text('Bitcoin'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(widget.isDark ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              widget.onThemeChanged(!widget.isDark);
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
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
                  '1 BTC = $bitcoinPrice $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            child: getPicker(),
          ),
        ],
      ),
    );
  }
}
