import 'package:flutter/material.dart';
import 'package:publico/styles/colors.dart';

class OutlineButton extends ElevatedButton {
  final double borderRadius;
  final Widget child;
  final Color? primaryColor;
  final Function()? onPressed;

  OutlineButton(
      {Key? key,
      required this.child,
      this.primaryColor,
      required this.onPressed,
      this.borderRadius = 10})
      : super(
          key: key,
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            side: const BorderSide(width: 1, color: kRichWhite),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            primary: primaryColor,
            elevation: 0,
            textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          child: child,
        );
}
