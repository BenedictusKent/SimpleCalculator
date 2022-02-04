import 'package:flutter/material.dart';
import 'package:simplecalculator/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalcButton extends StatelessWidget {
  final String text;
  final int fontColor;
  final int buttonColor;
  const CalcButton({Key key, this.text, this.fontColor, this.buttonColor})
      : super(key: key);

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
            context.read(currentNumberProvider).state = 0;
            context.read(historyNumberProvider).state = '';
          } else if (text == '+/-') {
            context.read(currentNumberProvider).state *= -1;
            context.read(historyNumberProvider).state =
                context.read(currentNumberProvider).state.toString();
          } else if (text == '%' ||
              text == '/' ||
              text == 'x' ||
              text == '-' ||
              text == '=' ||
              text == '.')
            print("Not implemented yet");
          // context.read(currentNumberProvider).state =
          //     context.read(currentNumberProvider).state;
          // else if (text == 'x')
          // TODO
          // else if (text == '-')
          // TODO
          else if (text == '+') {
            CalcApp.numberList.add(context.read(historyNumberProvider).state);
            context.read(historyNumberProvider).state += text;
          }
          // else if (text == '=')
          // TODO
          else {
            String temp = '0';
            String numberText = '';
            if (context.read(currentNumberProvider).state.toString().length <
                5) {
              if (context.read(historyNumberProvider).state.isNotEmpty) {
                if (context
                            .read(currentNumberProvider)
                            .state
                            .toString()
                            .length ==
                        4 &&
                    text == '00')
                  context.read(historyNumberProvider).state += '0';
                else
                  context.read(historyNumberProvider).state += text;
                temp = context.read(historyNumberProvider).state;
              } else if (text != '0' && text != '00') {
                context.read(historyNumberProvider).state += text;
                temp = context.read(historyNumberProvider).state;
              }
              context.read(currentNumberProvider).state = int.parse(temp);
            }
          }
        },
      ),
    );
  }
}
