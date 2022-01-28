import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            fontSize: 20.0,
          )),
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          minimumSize: Size(70, 70),
          primary: buttonColor != null ? Color(buttonColor) : Colors.grey[850],
        ),
        onPressed: () {},
      ),
    );
  }
}
