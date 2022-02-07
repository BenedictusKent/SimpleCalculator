import 'package:flutter/material.dart';
import 'package:simplecalculator/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:function_tree/function_tree.dart';

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
            CalcApp.operator = 0;
            context.read(currentNumberProvider).state = '0';
            context.read(historyNumberProvider).state = '';
          } else if (text == '+/-') {
            int temp = int.parse(context.read(currentNumberProvider).state);
            temp *= -1;
            context.read(currentNumberProvider).state = temp.toString();
          } else if (text == '%') {
          } else if (text == '/') {
          } else if (text == 'x') {
          } else if (text == '+') {
            // write currentNumber to historyNumber
            if (CalcApp.operator == 0)
              context.read(historyNumberProvider).state +=
                  context.read(currentNumberProvider).state;
            // write operation
            String temp = context.read(historyNumberProvider).state;
            temp = operationWriter(CalcApp.operator, text, temp);
            context.read(historyNumberProvider).state = temp;
            CalcApp.operator = 1;
          } else if (text == '-') {
            // write currentNumber to historyNumber
            if (CalcApp.operator == 0)
              context.read(historyNumberProvider).state +=
                  context.read(currentNumberProvider).state;
            // write operation
            String temp = context.read(historyNumberProvider).state;
            temp = operationWriter(CalcApp.operator, text, temp);
            context.read(historyNumberProvider).state = temp;
            CalcApp.operator = 2;
          } else if (text == '=') {
            context.read(historyNumberProvider).state +=
                context.read(currentNumberProvider).state;
            String temp = context
                .read(historyNumberProvider)
                .state
                .interpret()
                .toString();
            int result = int.parse(temp.substring(0, temp.length - 2));
            context.read(currentNumberProvider).state = result.toString();
            context.read(historyNumberProvider).state = '';
            CalcApp.reset = 1;
          } else {
            // reset currentNumberProvider and store operation
            if (CalcApp.operator != 0 || CalcApp.reset == 1) {
              context.read(currentNumberProvider).state = '0';
              CalcApp.operator = 0;
              CalcApp.reset = 0;
            }
            // take max 10 int
            if (context.read(currentNumberProvider).state.length < 10) {
              if (context.read(currentNumberProvider).state == '0') {
                if (text != '0' && text != '00') {
                  context.read(currentNumberProvider).state = text;
                  // context.read(historyNumberProvider).state += text;
                }
              } else {
                context.read(currentNumberProvider).state += text;
                // context.read(historyNumberProvider).state += text;
              }
            }
          }
        },
      ),
    );
  }
}
