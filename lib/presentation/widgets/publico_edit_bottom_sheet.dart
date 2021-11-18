import 'package:flutter/material.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class PublicoEditBottomSheet extends StatelessWidget {
  final BuildContext parentContext;
  final Function()? onEditPressed;
  final Function()? onDeletePressed;
  const PublicoEditBottomSheet({
    Key? key,
    required this.parentContext,
    this.onEditPressed,
    this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      enableDrag: false,
      builder: (bottomSheetContext) => Container(
        height: MediaQuery.of(context).size.height * 0.21,
        padding: const EdgeInsets.all(20),
        color: kRichWhite,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.bookmark,
                      color: kRichBlack,
                      size: 18,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '100',
                      style: kTextTheme.bodyText2!.copyWith(color: kRichBlack),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(bottomSheetContext);
                  },
                  child: const Icon(
                    Icons.close,
                    color: kRichBlack,
                    size: 20,
                  ),
                )
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(bottomSheetContext);
                if (onEditPressed != null) onEditPressed!();
              },
              child: Text(
                'Edit',
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
                    builder: (deleteSheetContext) => Container(
                      height: MediaQuery.of(parentContext).size.height * 0.2,
                      padding: const EdgeInsets.all(15),
                      color: kRichWhite,
                      child: Column(
                        children: [
                          Text(
                            'Yakin ingin menghapus?',
                            style: kTextTheme.headline6!
                                .copyWith(fontSize: 16, color: kRichBlack),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(deleteSheetContext);
                            },
                            child: Text(
                              'Batal',
                              style: kTextTheme.headline6!
                                  .copyWith(color: kRichBlack),
                            ),
                          ),
                          TextButton(
                            onPressed: onDeletePressed,
                            child: Text(
                              'Hapus',
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
                'Hapus',
                style: kTextTheme.headline6!.copyWith(color: kRed),
              ),
            ),
          ],
        ),
      ),
    );
  }
}