import 'dart:async';
import 'package:flutter/material.dart';
import 'package:simplecalculator/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:function_tree/function_tree.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CalcButton extends StatelessWidget {
  final String text;
  final int fontColor;
  final int buttonColor;
  const CalcButton({Key key, this.text, this.fontColor, this.buttonColor})
      : super(key: key);

  String operationWriter(int ops, String buttonText, String historyText) {
    // write operation into historyNumberProvider
    if (CalcApp.operator == 0)
      historyText += text;
    else {
      int len = historyText.length;
      String temp = historyText.substring(0, len - 1);
      temp += text;
      historyText = temp;
    }
    return historyText;
  }

  String historyWriter(String current, int minus, int ops) {
    // add parentheses if there is minus
    String history = '';
    if (minus == -1) {
      history += '(';
      history += current;
      history += ')';
      CalcApp.minus = 1;
    } else if (ops == 0) history += current;
    return history;
  }

  String opsFunc(
      String buttonText, String current, String history, int minus, int ops) {
    // write currentNumber to historyNumber
    String temp, tempHistory;
    tempHistory = history;
    temp = historyWriter(current, minus, ops);
    tempHistory += temp;
    // write operation
    temp = tempHistory;
    temp = operationWriter(ops, buttonText, temp);
    tempHistory = temp;
    if (buttonText == '+')
      CalcApp.operator = 1;
    else if (buttonText == '-') CalcApp.operator = 2;
    return tempHistory;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        child: Text(
          text,
          style: GoogleFonts.openSans(
              textStyle: TextStyle(
            color: fontColor != null ? Color(fontColor) : Colors.white,
            fontSize: 25.0,
          )),
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          minimumSize: Size(70, 70),
          primary: buttonColor != null ? Color(buttonColor) : Colors.grey[850],
        ),
        onPressed: () {
          if (text == 'AC') {
            CalcApp.reset = 0;
            CalcApp.minus = 1;
            CalcApp.operator = 0;
            context.read(currentNumberProvider).state = '0';
            context.read(historyNumberProvider).state = '';
          } else if (text == '+/-') {
            var temp;
            if (context.read(currentNumberProvider).state.contains('.'))
              temp = double.parse(context.read(currentNumberProvider).state);
            else
              temp = int.parse(context.read(currentNumberProvider).state);
            temp *= -1;
            CalcApp.minus *= -1;
            context.read(currentNumberProvider).state = temp.toString();
          } else if (text == '.') {
            context.read(currentNumberProvider).state += text;
          } else if (text == '%') {
          } else if (text == '+') {
            context.read(historyNumberProvider).state = opsFunc(
                text,
                context.read(currentNumberProvider).state,
                context.read(historyNumberProvider).state,
                CalcApp.minus,
                CalcApp.operator);
          } else if (text == '-') {
            context.read(historyNumberProvider).state = opsFunc(
                text,
                context.read(currentNumberProvider).state,
                context.read(historyNumberProvider).state,
                CalcApp.minus,
                CalcApp.operator);
          } else if (text == '/') {
          } else if (text == 'x') {
          } else if (text == '=') {
            // put parentheses if there is minus number
            if (CalcApp.minus == -1) {
              context.read(historyNumberProvider).state += '(';
              context.read(historyNumberProvider).state +=
                  context.read(currentNumberProvider).state;
              context.read(historyNumberProvider).state += ')';
              CalcApp.minus = 1;
            } else
              context.read(historyNumberProvider).state +=
                  context.read(currentNumberProvider).state;
            String temp = context
                .read(historyNumberProvider)
                .state
                .interpret()
                .toString();
            String result;
            if (temp.substring(temp.length - 2) == '.0') {
              result =
                  (int.parse(temp.substring(0, temp.length - 2))).toString();
              if (result.length > 15)
                result = (int.parse(temp.substring(0, temp.length - 2)))
                    .toStringAsFixed(3);
            } else
              result = (double.parse(temp)).toStringAsFixed(3);
            context.read(currentNumberProvider).state = result;
            context.read(historyNumberProvider).state = '';
            CalcApp.reset = 1;
          } else {
            // reset currentNumberProvider and store operation
            if (CalcApp.operator != 0 || CalcApp.reset == 1) {
              context.read(currentNumberProvider).state = '0';
              CalcApp.operator = 0;
              CalcApp.reset = 0;
              CalcApp.minus = 1;
            }
            // take max 10 int
            if (context.read(currentNumberProvider).state.length < 10) {
              if (context.read(currentNumberProvider).state == '0') {
                if (text != '0' && text != '00')
                  context.read(currentNumberProvider).state = text;
              } else
                context.read(currentNumberProvider).state += text;
            } else {
              Fluttertoast.showToast(
                msg: 'Max 10 numbers!',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
              );
            }
          }
        },
      ),
    );
  }
}
