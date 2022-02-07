import 'package:flutter/material.dart';
import 'package:simplecalculator/button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

final currentNumberProvider = StateProvider<String>((ref) {
  return '0';
});

final historyNumberProvider = StateProvider<String>((ref) {
  return '';
});

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: CalcApp(),
    );
  }
}

class CalcApp extends ConsumerWidget {
  static var arrayNum = [];
  static var arrayOps = [];
  static int firstNum = 0;
  static int operator = 0;
  final int colorBlack = 0xFF000000;
  final int colorGrey = 0xFFE0E0E0;
  final int colorOrange = 0xFFFFA726;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentNumber = watch(currentNumberProvider).state;
    final historyNumber = watch(historyNumberProvider).state;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10),
            alignment: Alignment(1, 1),
            child: Text(
              historyNumber.toString(),
              style: GoogleFonts.openSans(
                textStyle: TextStyle(fontSize: 20),
                color: Colors.grey[600],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
            alignment: Alignment(1, 1),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                currentNumber.toString(),
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(fontSize: 70),
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          // First row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CalcButton(
                text: "AC",
                fontColor: colorBlack,
                buttonColor: colorGrey,
              ),
              CalcButton(
                text: "+/-",
                fontColor: colorBlack,
                buttonColor: colorGrey,
              ),
              CalcButton(
                text: "%",
                fontColor: colorBlack,
                buttonColor: colorGrey,
              ),
              CalcButton(
                text: "/",
                buttonColor: colorOrange,
              ),
            ],
          ),
          // Second row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CalcButton(
                text: "7",
              ),
              CalcButton(
                text: "8",
              ),
              CalcButton(
                text: "9",
              ),
              CalcButton(
                text: "x",
                buttonColor: colorOrange,
              ),
            ],
          ),
          // Third row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CalcButton(
                text: "4",
              ),
              CalcButton(
                text: "5",
              ),
              CalcButton(
                text: "6",
              ),
              CalcButton(
                text: "-",
                buttonColor: colorOrange,
              ),
            ],
          ),
          // Fourth row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CalcButton(
                text: "1",
              ),
              CalcButton(
                text: "2",
              ),
              CalcButton(
                text: "3",
              ),
              CalcButton(
                text: "+",
                buttonColor: colorOrange,
              ),
            ],
          ),
          // Fifth row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CalcButton(
                text: ".",
              ),
              CalcButton(
                text: "0",
              ),
              CalcButton(
                text: "00",
              ),
              CalcButton(
                text: "=",
                buttonColor: colorOrange,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
