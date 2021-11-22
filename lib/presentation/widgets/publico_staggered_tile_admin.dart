import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class PublicoStaggeredTileAdmin extends StatelessWidget {
  final int tileIndex;
  final String imageUrl;
  final String category;
  final String title;
  final int? duration;
  final int? sourcesCount;

  const PublicoStaggeredTileAdmin({
    Key? key,
    this.tileIndex = 0,
    required this.imageUrl,
    required this.category,
    required this.title,
    this.duration,
    this.sourcesCount,
  }) : super(key: key);

  String formatedTime(int? secTime) {
    if (secTime == null) return '';

    String getParsedTime(String time) {
      if (time.length <= 1) return "0$time";
      return time;
    }

    int min = secTime ~/ 60;
    int sec = secTime % 60;

    String parsedTime =
        getParsedTime(min.toString()) + " : " + getParsedTime(sec.toString());

    return parsedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                imageBuilder: (_, image) {
                  return Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  );
                },
                placeholder: (_, img) {
                  return SizedBox(
                    width: 250,
                    height: tileIndex.isEven ? 200 : 350,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: kMikadoOrange,
                        strokeWidth: 3,
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: 5,
              left: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: kLightGrey2,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Center(
                  child: category == 'Video Singkat' ||
                          category == 'Video Materi'
                      ? Text(
                          formatedTime(duration!),
                          style: kTextTheme.overline!
                              .copyWith(color: kRichBlack, fontSize: 10),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(
                              Icons.collections_bookmark_rounded,
                              color: kRichBlack,
                              size: 12,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '$sourcesCount',
                              style: kTextTheme.overline!
                                  .copyWith(color: kRichBlack, fontSize: 12),
                            )
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          category,
          style:
              kTextTheme.overline!.copyWith(color: kMikadoOrange, fontSize: 13),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: kTextTheme.caption!.copyWith(color: kRichBlack, fontSize: 14),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ],
    );
  }
}
