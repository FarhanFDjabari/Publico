import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:publico/presentation/widgets/photo_viewer.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class InfographicTile extends StatefulWidget {
  final source;
  const InfographicTile({Key? key, required this.source}) : super(key: key);

  @override
  _InfographicTileState createState() => _InfographicTileState();
}

class _InfographicTileState extends State<InfographicTile>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  bool _isExpand = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Stack(
            children: [
              ExpandablePageView.builder(
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: widget.source['illustrations'].length,
                  itemBuilder: (_, index) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PhotoViewer(
                                imageUrl: widget.source['illustrations'][index],
                              ),
                            ));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: kLightGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: widget.source['illustrations'][index],
                            imageBuilder: (_, provider) {
                              return Image.network(
                                widget.source['illustrations'][index],
                                fit: BoxFit.cover,
                              );
                            },
                            progressIndicatorBuilder:
                                (context, value, progress) {
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.45,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: kMikadoOrange,
                                    value: progress.progress,
                                    backgroundColor: kGrey,
                                    strokeWidth: 3,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }),
              Positioned(
                top: 10,
                right: 10,
                child: widget.source['illustrations'].length > 1
                    ? Container(
                        width: 40,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: kLightGrey2,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Center(
                          child: Text(
                            '${_currentIndex + 1}/${widget.source['illustrations'].length}',
                            style: kTextTheme.overline!.copyWith(
                              color: kRichBlack,
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(
                        width: 40,
                        height: 20,
                      ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          widget.source['illustrations'].length > 1
              ? SizedBox(
                  height: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.source['illustrations'].length,
                      (pictureIndex) => _buildInfographicsDot(
                          index: pictureIndex, currentIndex: _currentIndex),
                    ),
                  ),
                )
              : const SizedBox(
                  height: 5,
                ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: kMikadoOrange,
                child: Icon(
                  Icons.source_rounded,
                  color: kRichWhite,
                  size: 18,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    setState(() {
                      _isExpand = !_isExpand;
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.source['source_name'],
                        style: kTextTheme.overline!.copyWith(
                          color: kMikadoOrange,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        widget.source['description'],
                        style: kTextTheme.overline!.copyWith(
                          color: kRichBlack,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: _isExpand ? 500 : 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  AnimatedContainer _buildInfographicsDot(
      {required int index, required int currentIndex}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 750),
      width: 5,
      height: 5,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: currentIndex == index ? kMikadoOrange : kLightGrey,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
