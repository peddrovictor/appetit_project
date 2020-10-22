import 'package:flutter/material.dart';

///
/// Created by Thasciano Carvalho on 29/10/2019.
/// thasciano@gmail.com
///
class OrangeButton extends StatelessWidget {

  String text;
  double fontSize;
  Function onPress;
  Color color;

  OrangeButton(this.text, this.fontSize, this.color, this.onPress);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPress,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(100.0)),
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
        child: Text(
            text,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600, color: Colors.white)
        ),
      ),
    );
  }
}
