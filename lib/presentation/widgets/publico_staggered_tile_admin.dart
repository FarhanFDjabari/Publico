import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class PublicoStaggeredTileAdmin extends StatelessWidget {
  final int tileIndex;
  final String imageUrl;
  final String category;
  final String title;
  const PublicoStaggeredTileAdmin({
    Key? key,
    this.tileIndex = 0,
    required this.imageUrl,
    required this.category,
    required this.title,
  }) : super(key: key);

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
                width: 40,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: kLightGrey2,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(
                        Icons.collections_bookmark_rounded,
                        color: kRichBlack,
                        size: 12,
                      ),
                      Text(
                        '5',
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
        Text(
          category,
          style:
              kTextTheme.overline!.copyWith(color: kMikadoOrange, fontSize: 13),
        ),
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
