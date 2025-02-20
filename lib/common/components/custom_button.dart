import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.textButton,
      this.backgroundColor,
      this.disabledBackgroundColor});

  final VoidCallback onPressed;
  final String textButton;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabledBackgroundColor != null ? null : onPressed,
      child: Container(
        height: 48,
        child: Center(
          child: Text(
            textButton,
            style: TextStyle(
              fontFamily: 'Lato',
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Color(0xff8875FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        disabledBackgroundColor: disabledBackgroundColor,
      ),
    );
  }
}
