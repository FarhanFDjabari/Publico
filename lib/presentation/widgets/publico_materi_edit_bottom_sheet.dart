import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:publico/presentation/bloc/video_materi/video_materi_cubit.dart';
import 'package:publico/presentation/widgets/publico_snackbar.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class PublicoMateriEditBottomSheet extends StatelessWidget {
  final BuildContext parentContext;
  final int bookmarkCount;
  final Function()? onEditPressed;
  final Function()? onDeletePressed;
  const PublicoMateriEditBottomSheet({
    Key? key,
    required this.parentContext,
    required this.bookmarkCount,
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
                      '$bookmarkCount',
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
                          BlocConsumer<VideoMateriCubit, VideoMateriState>(
                            listener: (_, state) {
                              if (state is DeleteVideoMateriSuccess) {
                                Navigator.of(parentContext)
                                  ..pop()
                                  ..pop();
                                Get.showSnackbar(
                                  PublicoSnackbar(
                                    message: state.message,
                                  ),
                                );
                              } else if (state is VideoMateriError) {
                                Navigator.pop(parentContext);
                                Get.showSnackbar(
                                  PublicoSnackbar(
                                    message: state.message,
                                  ),
                                );
                              }
                            },
                            builder: (builderContext, state) {
                              if (state is DeleteVideoMateriLoading) {
                                return const CircularProgressIndicator();
                              }
                              return TextButton(
                                onPressed: onDeletePressed,
                                child: Text(
                                  'Hapus',
                                  style: kTextTheme.headline6!
                                      .copyWith(color: kRed),
                                ),
                              );
                            },
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
