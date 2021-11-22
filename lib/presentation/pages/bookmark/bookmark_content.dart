import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:publico/domain/entities/infographic.dart';
import 'package:publico/domain/entities/video_materi.dart';
import 'package:publico/presentation/bloc/bookmark/cubit/bookmark_cubit.dart';
import 'package:publico/presentation/bloc/video_materi/video_materi_cubit.dart';
import 'package:publico/presentation/pages/detail/infographics_detail_page.dart';
import 'package:publico/presentation/pages/detail/video_materi_detail_page.dart';
import 'package:publico/presentation/pages/detail/video_singkat_detail_page.dart';
import 'package:publico/presentation/widgets/publico_staggered_tile.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class BookmarkContent extends StatelessWidget {
  const BookmarkContent({
    Key? key,
    required this.selectedBookmark,
  }) : super(key: key);

  final int selectedBookmark;

  @override
  Widget build(BuildContext context) {
    switch (selectedBookmark) {
      case 0:
        context.read<BookmarkCubit>().getAllFromBookmark();
        break;
      case 1:
        context.read<BookmarkCubit>().getInfographicFromBookmark();
        break;
      case 2:
        context.read<BookmarkCubit>().getVideoMateriFromBookmark();
        break;
      case 3:
        context.read<BookmarkCubit>().getVideoSingkatFromBookmark();
        break;
      default:
    }
    return BlocBuilder<BookmarkCubit, BookmarkState>(
      builder: (context, state) {
        if (state is GetAllBookmarkSuccess) {
          return StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: state.bookmarks.length,
            itemBuilder: (BuildContext itemContext, int index) {
              if (state.bookmarks[index] is Infographic) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      InfographicsDetailPage.routeName,
                      arguments: state.bookmarks[index],
                    );
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: PublicoStaggeredTile(
                    tileIndex: index,
                    sourcesCount: state.bookmarks[index].sources.length,
                    title: state.bookmarks[index].title,
                    imageUrl: state
                        .bookmarks[index].sources.first['illustrations'][0],
                    category: 'Infografis',
                  ),
                );
              } else if (state.bookmarks[index] is VideoMateri) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      VideoMateriDetailPage.routeName,
                      arguments: state.bookmarks[index],
                    );
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: PublicoStaggeredTile(
                    tileIndex: index,
                    duration: state.bookmarks[index].duration,
                    title: state.bookmarks[index].title,
                    imageUrl: state.bookmarks[index].thumbnailUrl,
                    category: state.bookmarks[index].type,
                  ),
                );
              }
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    VideoSingkatDetailPage.routeName,
                    arguments: state.bookmarks[index],
                  );
                },
                borderRadius: BorderRadius.circular(10),
                child: PublicoStaggeredTile(
                  tileIndex: index,
                  duration: state.bookmarks[index].duration,
                  title: state.bookmarks[index].title,
                  imageUrl: state.bookmarks[index].thumbnailUrl,
                  category: state.bookmarks[index].type,
                ),
              );
            },
            staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
            mainAxisSpacing: 15.0,
            crossAxisSpacing: 8.0,
          );
        } else if (state is GetVideoMateriBookmarkSuccess) {
          return StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: state.videoMateriList.length,
            itemBuilder: (BuildContext itemContext, int index) => InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  VideoMateriDetailPage.routeName,
                  arguments: state.videoMateriList[index],
                );
              },
              borderRadius: BorderRadius.circular(10),
              child: PublicoStaggeredTile(
                tileIndex: index,
                duration: state.videoMateriList[index].duration,
                title: state.videoMateriList[index].title,
                imageUrl: state.videoMateriList[index].thumbnailUrl,
                category: state.videoMateriList[index].type,
              ),
            ),
            staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
            mainAxisSpacing: 15.0,
            crossAxisSpacing: 8.0,
          );
        } else if (state is GetVideoSingkatBookmarkSuccess) {
          return StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: state.videoSingkatList.length,
            itemBuilder: (BuildContext itemContext, int index) => InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  VideoSingkatDetailPage.routeName,
                  arguments: state.videoSingkatList[index],
                );
              },
              borderRadius: BorderRadius.circular(10),
              child: PublicoStaggeredTile(
                tileIndex: index,
                duration: state.videoSingkatList[index].duration,
                title: state.videoSingkatList[index].title,
                imageUrl: state.videoSingkatList[index].thumbnailUrl,
                category: state.videoSingkatList[index].type,
              ),
            ),
            staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
            mainAxisSpacing: 15.0,
            crossAxisSpacing: 8.0,
          );
        } else if (state is GetInfographicBookmarkSuccess) {
          return StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: state.infographicList.length,
            itemBuilder: (BuildContext itemContext, int index) => InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  InfographicsDetailPage.routeName,
                  arguments: state.infographicList[index],
                );
              },
              borderRadius: BorderRadius.circular(10),
              child: PublicoStaggeredTile(
                tileIndex: index,
                sourcesCount: state.infographicList[index].sources.length,
                title: state.infographicList[index].title,
                imageUrl: state
                    .infographicList[index].sources.first['illustrations'][0],
                category: 'Infografis',
              ),
            ),
            staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
            mainAxisSpacing: 15.0,
            crossAxisSpacing: 8.0,
          );
        } else if (state is VideoMateriError) {
          return Center(
            child: Text(
              'Belum ada bookmark yang tersedia',
              style: kTextTheme.bodyText2!.copyWith(color: kRichBlack),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
