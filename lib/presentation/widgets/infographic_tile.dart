import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

import 'expandable_page_view.dart';

class InfographicTile extends StatefulWidget {
  const InfographicTile({Key? key}) : super(key: key);

  @override
  _InfographicTileState createState() => _InfographicTileState();
}

class _InfographicTileState extends State<InfographicTile> {
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
              ExpandablePageView(
                onPageChange: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: List.generate(
                  3,
                  (index) => Container(
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
                        imageUrl:
                            'https://marketplace.canva.com/EADaooG1kwk/2/0/704w/canva-top-major-south-america-commodities-_IBpJMSh0_Y.jpg',
                        imageBuilder: (_, provider) {
                          return Image.network(
                            'https://marketplace.canva.com/EADaooG1kwk/2/0/704w/canva-top-major-south-america-commodities-_IBpJMSh0_Y.jpg',
                            fit: BoxFit.cover,
                          );
                        },
                        placeholder: (_, status) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: kMikadoOrange,
                              strokeWidth: 3,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 40,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: kLightGrey2,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Center(
                    child: Text(
                      '${_currentIndex + 1}/3',
                      style: kTextTheme.overline!.copyWith(
                        color: kRichBlack,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (pictureIndex) => _buildInfographicsDot(
                    index: pictureIndex, currentIndex: _currentIndex),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: kMikadoOrange,
                child: Icon(
                  Icons.twenty_three_mp_rounded,
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
                        'Lorem Ipsum is simply dummy text of the printing[Sumber]',
                        style: kTextTheme.overline!.copyWith(
                          color: kMikadoOrange,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. [Caption]',
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
