import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class PublicoSnackbar extends GetBar {
  final String message;
  PublicoSnackbar({this.message = '', Key? key})
      : super(
          key: key,
          backgroundColor: kRichBlack.withOpacity(0.7),
          borderRadius: 10,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
          snackStyle: SnackStyle.FLOATING,
          margin: const EdgeInsets.symmetric(
            vertical: 70,
            horizontal: 35,
          ),
          messageText: Text(
            message,
            textAlign: TextAlign.center,
            style: kTextTheme.caption!.copyWith(
              color: kRichWhite,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        );
}
