import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:publico/styles/colors.dart';

class VideoSingkatDetailPage extends StatefulWidget {
  static const routeName = '/video-singkat-detail';
  const VideoSingkatDetailPage({Key? key}) : super(key: key);

  @override
  _VideoSingkatDetailPageState createState() => _VideoSingkatDetailPageState();
}

class _VideoSingkatDetailPageState extends State<VideoSingkatDetailPage> {
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
            onPressed: () {},
            icon: const Icon(
              Icons.bookmark_outline_rounded,
              color: kRichBlack,
            ),
          ),
        ],
        centerTitle: true,
      ),
    );
  }
}
