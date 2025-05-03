import 'package:flutter/material.dart';
import '../constants.dart';

class BottomButton extends StatelessWidget {
  BottomButton({required this.onTap, required this.buttonTitle});

  final void Function()? onTap;
  final String buttonTitle;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: bottomContainerColour,
        padding: EdgeInsets.only(bottom: 10.0),
        margin: EdgeInsets.only(top: 5.0),
        width: double.infinity,
        height: bottomContainerHeight,
        child: Center(
          child: Text(
            buttonTitle.toString(),
            style: largeButtonStyle,
          ),
        ),
      ),
    );
  }
}