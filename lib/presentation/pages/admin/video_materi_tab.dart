import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_storage/get_storage.dart';
import 'package:publico/presentation/bloc/video_materi/video_materi_cubit.dart';
import 'package:publico/presentation/pages/admin/detail/admin_video_materi_detail.dart';
import 'package:publico/presentation/pages/admin/post/video_materi_post_page.dart';
import 'package:publico/presentation/widgets/publico_staggered_tile_admin.dart';
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
    context
        .read<VideoMateriCubit>()
        .getVideoMateriPostsByUidFirestore(GetStorage().read('uid'));
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
              child: BlocBuilder<VideoMateriCubit, VideoMateriState>(
                builder: (context, state) {
                  if (state is GetVideoMateriPostsByUidSuccess) {
                    return StaggeredGridView.countBuilder(
                      crossAxisCount: 4,
                      itemCount: state.videoMateriList.length,
                      itemBuilder: (BuildContext itemContext, int index) =>
                          InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AdminVideoMateriDetailPage.routeName,
                            arguments: state.videoMateriList[index],
                          ).then((_) => context
                              .read<VideoMateriCubit>()
                              .getVideoMateriPostsByUidFirestore(
                                  GetStorage().read('uid')));
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: PublicoStaggeredTileAdmin(
                          tileIndex: index,
                          duration: state.videoMateriList[index].duration,
                          title: state.videoMateriList[index].title,
                          imageUrl: state.videoMateriList[index].thumbnailUrl,
                          category: state.videoMateriList[index].type,
                        ),
                      ),
                      staggeredTileBuilder: (int index) =>
                          const StaggeredTile.fit(2),
                      mainAxisSpacing: 15.0,
                      crossAxisSpacing: 8.0,
                    );
                  } else if (state is GetVideoMateriPostsByUidError) {
                    return const Center(
                      child: Text('Tidak ada video materi'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const VideoMateriPostPage(),
                  ))
              .then((_) => context
                  .read<VideoMateriCubit>()
                  .getVideoMateriPostsByUidFirestore(GetStorage().read('uid')));
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
