import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  final Color buttonColor, textColor;

  const RoundButton(
      {Key key,
      this.buttonText,
      this.onPressed,
      this.buttonColor,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      //margin: EdgeInsets.symmetric(vertical: 3),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,

          ),
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
