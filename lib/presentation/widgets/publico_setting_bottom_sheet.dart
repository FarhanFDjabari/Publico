import 'package:flutter/material.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class PublicoSettingBottomSheet extends StatelessWidget {
  final BuildContext parentContext;
  final Function()? onHelpPressed;
  final Function()? onExitPressed;
  const PublicoSettingBottomSheet({
    Key? key,
    required this.parentContext,
    this.onHelpPressed,
    this.onExitPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      enableDrag: false,
      builder: (bottomSheetContext) => Container(
        height: MediaQuery.of(context).size.height * 0.18,
        padding: const EdgeInsets.all(20),
        color: kRichWhite,
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(bottomSheetContext);
                if (onHelpPressed != null) onHelpPressed!();
              },
              child: Text(
                'Bantuan',
                style: kTextTheme.headline6!.copyWith(color: kRichBlack),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(bottomSheetContext);
                showModalBottomSheet(
                  backgroundColor: kRichWhite,
                  context: parentContext,
                  isDismissible: false,
                  enableDrag: false,
                  builder: (_) => BottomSheet(
                    onClosing: () {},
                    enableDrag: false,
                    builder: (exitSheetContext) => Container(
                      height: MediaQuery.of(parentContext).size.height * 0.2,
                      padding: const EdgeInsets.all(15),
                      color: kRichWhite,
                      child: Column(
                        children: [
                          Text(
                            'Yakin ingin keluar aplikasi?',
                            style: kTextTheme.headline6!
                                .copyWith(fontSize: 16, color: kRichBlack),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(exitSheetContext);
                            },
                            child: Text(
                              'Batal',
                              style: kTextTheme.headline6!
                                  .copyWith(color: kRichBlack),
                            ),
                          ),
                          TextButton(
                            onPressed: onExitPressed,
                            child: Text(
                              'Keluar',
                              style:
                                  kTextTheme.headline6!.copyWith(color: kRed),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: Text(
                'Keluar',
                style: kTextTheme.headline6!.copyWith(color: kRed),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
