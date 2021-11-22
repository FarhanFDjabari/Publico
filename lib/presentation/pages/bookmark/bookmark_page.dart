import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:publico/presentation/bloc/video_materi/video_materi_cubit.dart';
import 'package:publico/presentation/widgets/chip_button.dart';
import 'package:publico/presentation/widgets/publico_staggered_tile.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class BookmarkPage extends StatefulWidget {
  static const routeName = '/bookmark';
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            SizedBox(
              height: 29,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                    child: ChipButton(
                      title: 'Semua',
                      width: 105,
                      selectedIndex: _selectedIndex,
                      itemIndex: 0,
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    child: ChipButton(
                      title: 'Infografis',
                      width: 105,
                      selectedIndex: _selectedIndex,
                      itemIndex: 1,
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 2;
                      });
                    },
                    child: ChipButton(
                      title: 'Video Materi',
                      width: 105,
                      selectedIndex: _selectedIndex,
                      itemIndex: 2,
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 3;
                      });
                    },
                    child: ChipButton(
                      title: 'Video Singkat',
                      width: 105,
                      selectedIndex: _selectedIndex,
                      itemIndex: 3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<VideoMateriCubit, VideoMateriState>(
                builder: (context, state) {
                  if (state is GetVideoMateriBookmarkSuccess) {
                    return StaggeredGridView.countBuilder(
                      crossAxisCount: 4,
                      itemCount: state.videoMateriList.length,
                      itemBuilder: (BuildContext itemContext, int index) =>
                          InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(10),
                        child: PublicoStaggeredTile(
                          tileIndex: index,
                          duration: state.videoMateriList[index].duration,
                          title: state.videoMateriList[index].title,
                          imageUrl: state.videoMateriList[index].thumbnailUrl,
                          category: 'Video Matery',
                        ),
                      ),
                      staggeredTileBuilder: (int index) =>
                          const StaggeredTile.fit(2),
                      mainAxisSpacing: 15.0,
                      crossAxisSpacing: 8.0,
                    );
                  } else if (state is VideoMateriError) {
                    return Center(
                      child: Text(
                        'Belum ada video materi yang tersedia',
                        style:
                            kTextTheme.bodyText2!.copyWith(color: kRichBlack),
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
