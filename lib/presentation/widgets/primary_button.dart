import 'package:flutter/material.dart';

class PrimaryButton extends ElevatedButton {
  final double borderRadius;
  final Widget child;
  final Color? primaryColor;
  final Function()? onPressed;

  PrimaryButton(
      {Key? key,
      required this.child,
      this.primaryColor,
      required this.onPressed,
      this.borderRadius = 10})
      : super(
          key: key,
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
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
