import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:publico/presentation/pages/admin/edit/infographic_edit_page.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class AdminInfographicsDetailPage extends StatefulWidget {
  static const routeName = '/admin-infographics-detail';
  final String postId;
  const AdminInfographicsDetailPage({Key? key, required this.postId})
      : super(key: key);

  @override
  _AdminInfographicsDetailPageState createState() =>
      _AdminInfographicsDetailPageState();
}

class _AdminInfographicsDetailPageState
    extends State<AdminInfographicsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kRichWhite,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: kRichBlack,
          ),
        ),
        title: SvgPicture.asset(
          'assets/svg/Publico.svg',
          height: 24,
          width: 50,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                InfographicEditPage.routeName,
                arguments: 'secret',
              );
            },
            icon: const Icon(
              Icons.more_horiz,
              color: kRichBlack,
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Subsidi Pemerintah dan Bantuan untuk Masyarakat Miskin [Tema]',
                  style: kTextTheme.overline!.copyWith(
                    color: kMikadoOrange,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'Economy graph on night city scape with tall [Judul]',
                  style: kTextTheme.headline6!.copyWith(color: kRichBlack),
                  overflow: TextOverflow.fade,
                ),
                Column(
                  children: List.generate(
                    3,
                    (index) => Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(0),
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
                                        fit: BoxFit.contain,
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Center(
                                    child: Text(
                                      '1/2',
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
                                2,
                                (pictureIndex) => _buildInfographicsDot(
                                    index: pictureIndex, currentIndex: 1),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
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
                              const SizedBox(width: 5),
                              Expanded(
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
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
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
