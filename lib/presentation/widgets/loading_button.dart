import 'package:flutter/material.dart';

class LoadingButton extends ElevatedButton {
  final double borderRadius;
  final Widget child;
  final Color? primaryColor;

  LoadingButton(
      {Key? key,
      required this.child,
      this.primaryColor,
      this.borderRadius = 10})
      : super(
          key: key,
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius)),
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
