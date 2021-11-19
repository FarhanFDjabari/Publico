import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_storage/get_storage.dart';
import 'package:publico/presentation/bloc/video_singkat/video_singkat_cubit.dart';
import 'package:publico/presentation/pages/admin/detail/admin_video_singkat_detail.dart';
import 'package:publico/presentation/pages/admin/post/video_singkat_post_page.dart';
import 'package:publico/presentation/widgets/publico_staggered_tile_admin.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class VideoSingkatTab extends StatefulWidget {
  static const routeName = '/admin-video-singkat';
  const VideoSingkatTab({Key? key}) : super(key: key);

  @override
  _VideoSingkatTabState createState() => _VideoSingkatTabState();
}

class _VideoSingkatTabState extends State<VideoSingkatTab> {
  final _searchQueryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context
        .read<VideoSingkatCubit>()
        .getVideoSingkatPostsByUidFirestore(GetStorage().read('uid'));
    return Scaffold(
      body: SafeArea(
        child: Padding(
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
                child: BlocBuilder<VideoSingkatCubit, VideoSingkatState>(
                  builder: (context, state) {
                    if (state is GetVideoSingkatPostsByUidSuccess) {
                      return StaggeredGridView.countBuilder(
                        crossAxisCount: 4,
                        itemCount: state.videoSingkats.length,
                        itemBuilder: (BuildContext itemContext, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AdminVideoSingkatDetailPage.routeName,
                                arguments: state.videoSingkats[index],
                              );
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: PublicoStaggeredTileAdmin(
                              tileIndex: index,
                              title: state.videoSingkats[index].title,
                              imageUrl: state.videoSingkats[index].thumbnailUrl,
                              category: state.videoSingkats[index].type,
                            ),
                          );
                        },
                        staggeredTileBuilder: (int index) =>
                            const StaggeredTile.fit(2),
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 8.0,
                      );
                    } else if (state is GetVideoSingkatPostsByUidError) {
                      return const Center(
                        child: Text('Tidak ada video singkat'),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const VideoSingkatPostPage(),
              )).then(
            (value) => context
                .read<VideoSingkatCubit>()
                .getVideoSingkatPostsByUidFirestore(
                  GetStorage().read('uid'),
                ),
          );
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
