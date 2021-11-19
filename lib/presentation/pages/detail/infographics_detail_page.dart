import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:publico/presentation/widgets/infographic_tile.dart';
import 'package:publico/presentation/widgets/publico_snackbar.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class InfographicsDetailPage extends StatefulWidget {
  static const routeName = '/infographics-detail';
  final String postId;
  const InfographicsDetailPage({Key? key, required this.postId})
      : super(key: key);

  @override
  _InfographicsDetailPageState createState() => _InfographicsDetailPageState();
}

class _InfographicsDetailPageState extends State<InfographicsDetailPage> {
  int _currentIndex = 0;

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
              Get.showSnackbar(
                PublicoSnackbar(
                  message: 'Ditambahkan ke bookmark',
                ),
              );
            },
            icon: const Icon(
              Icons.bookmark_outline_rounded,
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
                    (index) => InfographicTile(),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
