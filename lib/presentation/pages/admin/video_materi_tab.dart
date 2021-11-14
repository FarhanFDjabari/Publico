import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:publico/presentation/pages/admin/post/video_materi_post_page.dart';
import 'package:publico/presentation/widgets/publico_staggered_tile.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class VideoMateriTab extends StatefulWidget {
  static const routeName = '/admin-video-materi';
  const VideoMateriTab({Key? key}) : super(key: key);

  @override
  _VideoMateriTabState createState() => _VideoMateriTabState();
}

class _VideoMateriTabState extends State<VideoMateriTab> {
  final _searchQueryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(
          children: [
            TextField(
              controller: _searchQueryController,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                isDense: true,
                hintText: 'Cari',
                hintStyle: kTextTheme.bodyText2!.copyWith(
                  color: kLightGrey,
                ),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    _searchQueryController.clear();
                  },
                  icon: const Icon(
                    Icons.cancel_rounded,
                  ),
                ),
              ),
              autofocus: false,
              style: kTextTheme.bodyText2!.copyWith(
                color: kRichBlack,
              ),
              onChanged: (value) {},
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                itemCount: 12,
                itemBuilder: (BuildContext itemContext, int index) => InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(10),
                  child: PublicoStaggeredTile(
                    tileIndex: index,
                    title:
                        'Subsidi Pemerintah dan Bantuan untuk lorem ipsum asdaksdka sdass dasdasdas',
                    imageUrl:
                        'https://marketplace.canva.com/EADaooG1kwk/2/0/704w/canva-top-major-south-america-commodities-_IBpJMSh0_Y.jpg',
                    category: 'Infografis',
                  ),
                ),
                staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 8.0,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const VideoMateriPostPage(),
              ));
        },
        child: const Icon(
          Icons.add,
          color: kRichWhite,
        ),
        backgroundColor: kMikadoOrange,
      ),
    );
  }
}