import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:publico/domain/entities/infographic.dart';
import 'package:publico/presentation/bloc/infographic/infographic_cubit.dart';
import 'package:publico/presentation/pages/admin/edit/infographic_edit_page.dart';
import 'package:publico/presentation/widgets/infographic_tile.dart';
import 'package:publico/presentation/widgets/publico_info_edit_bottom_sheet.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class AdminInfographicsDetailPage extends StatefulWidget {
  static const routeName = '/admin-infographics-detail';
  final Infographic infographic;
  const AdminInfographicsDetailPage({Key? key, required this.infographic})
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
              showModalBottomSheet(
                backgroundColor: kRichWhite,
                context: context,
                isDismissible: true,
                builder: (_) => PublicoInfoEditBottomSheet(
                  parentContext: context,
                  bookmarkCount: widget.infographic.bookmarkCount,
                  onDeletePressed: () {
                    final illustrationsUrl = widget.infographic.sources
                        .expand((element) => element['illustrations'])
                        .toList();
                    context
                        .read<InfographicCubit>()
                        .deleteInfographicPostFirestore(widget.infographic.id,
                            illustrationsUrl, 'infographics');
                  },
                  onEditPressed: () {
                    Navigator.pushNamed(
                      context,
                      InfographicEditPage.routeName,
                      arguments: widget.infographic,
                    );
                  },
                ),
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
                        source: widget.infographic.sources[index]),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
