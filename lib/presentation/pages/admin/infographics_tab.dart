import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:publico/styles/colors.dart';

class InfographicsTab extends StatefulWidget {
  static const routeName = '/admin-infographics';
  const InfographicsTab({Key? key}) : super(key: key);

  @override
  _InfographicsTabState createState() => _InfographicsTabState();
}

class _InfographicsTabState extends State<InfographicsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        iconTheme: const IconThemeData(color: kRichWhite),
        backgroundColor: kMikadoOrange,
        spacing: 8,
        spaceBetweenChildren: 8,
        overlayColor: kRichBlack,
        children: [
          SpeedDialChild(
            backgroundColor: kRichWhite,
            onTap: () {},
            child: const Icon(
              Icons.create_new_folder_outlined,
              color: kMikadoOrange,
            ),
            labelWidget: Container(
              margin: const EdgeInsets.only(right: 8),
              child: const Text('Tema'),
            ),
          ),
          SpeedDialChild(
            backgroundColor: kRichWhite,
            onTap: () {},
            child: const Icon(
              Icons.insights_outlined,
              color: kMikadoOrange,
            ),
            labelWidget: Container(
              margin: const EdgeInsets.only(right: 8),
              child: const Text('Infografis'),
            ),
          ),
        ],
      ),
    );
  }
}
