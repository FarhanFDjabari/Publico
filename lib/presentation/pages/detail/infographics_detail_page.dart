import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:publico/domain/entities/infographic.dart';
import 'package:publico/presentation/bloc/infographic/infographic_cubit.dart';
import 'package:publico/presentation/widgets/infographic_tile.dart';
import 'package:publico/presentation/widgets/publico_snackbar.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class InfographicsDetailPage extends StatefulWidget {
  static const routeName = '/infographics-detail';
  final Infographic infographic;
  const InfographicsDetailPage({Key? key, required this.infographic})
      : super(key: key);

  @override
  _InfographicsDetailPageState createState() => _InfographicsDetailPageState();
}

class _InfographicsDetailPageState extends State<InfographicsDetailPage> {
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
          BlocListener<InfographicCubit, InfographicState>(
            listener: (context, state) {
              if (state is InsertInfographicBookmarkSuccess) {
                Get.showSnackbar(
                  PublicoSnackbar(
                    message: state.message,
                  ),
                );
              } else if (state is InfographicError) {
                Get.showSnackbar(
                  PublicoSnackbar(
                    message: state.message,
                  ),
                );
              }
            },
            child: IconButton(
              onPressed: () {
                context
                    .read<InfographicCubit>()
                    .insertInfographicToBookmark(widget.infographic);
              },
              icon: const Icon(
                Icons.bookmark_outline_rounded,
                color: kRichBlack,
              ),
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
                  widget.infographic.themeName,
                  style: kTextTheme.overline!.copyWith(
                    color: kMikadoOrange,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  widget.infographic.title,
                  style: kTextTheme.headline6!.copyWith(color: kRichBlack),
                  overflow: TextOverflow.fade,
                ),
                Column(
                  children: List.generate(
                    widget.infographic.sources.length,
                    (index) => InfographicTile(
                      source: widget.infographic.sources[index],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
