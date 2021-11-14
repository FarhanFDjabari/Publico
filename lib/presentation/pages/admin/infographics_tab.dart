import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:publico/presentation/pages/admin/post/infographic_post_page.dart';
import 'package:publico/presentation/pages/admin/post/post_theme_page.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 175 / 75,
          ),
          shrinkWrap: true,
          itemCount: 9,
          itemBuilder: (_, index) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://images.pexels.com/photos/7947707/pexels-photo-7947707.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                    imageBuilder: (_, image) {
                      return ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          kRichBlack.withOpacity(0.45),
                          BlendMode.darken,
                        ),
                        child: Image.network(
                          'https://images.pexels.com/photos/7947707/pexels-photo-7947707.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                    placeholder: (_, value) {
                      return const SizedBox(
                        height: 75,
                        child: Center(
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              color: kMikadoOrange,
                              strokeWidth: 3,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      'Semua',
                      style: kTextTheme.caption!.copyWith(
                        color: kRichWhite,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PostThemePage()),
              );
            },
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const InfographicPostPage()),
              );
            },
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
