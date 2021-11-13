import 'package:flutter/material.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class ChipButton extends StatelessWidget {
  final int itemIndex;
  final int selectedIndex;
  final double? width;
  final String title;

  const ChipButton({
    Key? key,
    this.itemIndex = 0,
    this.width,
    required this.selectedIndex,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: width,
      height: 29,
      decoration: BoxDecoration(
        color: selectedIndex == itemIndex ? kMikadoOrange : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kMikadoOrange),
      ),
      duration: const Duration(milliseconds: 550),
      child: Center(
        child: Text(
          title,
          style: kTextTheme.bodyText2!.copyWith(
            color: selectedIndex == itemIndex ? kRichWhite : kMikadoOrange,
          ),
        ),
      ),
    );
  }
}
