import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:publico/domain/entities/infographic.dart';
import 'package:publico/domain/entities/video_materi.dart';
import 'package:publico/domain/entities/video_singkat.dart';
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
          if (state.bookmarks.isNotEmpty) {
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
                      ).then((value) {
                        context.read<BookmarkCubit>().getAllFromBookmark();
                      });
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: PublicoStaggeredTile(
                      tileIndex: index,
                      sourcesCount: state.bookmarks[index].sources.length,
                      title: state.bookmarks[index].title,
                      imageUrl: state
                          .bookmarks[index].sources.first['illustrations'][0],
                      category: 'Infografis',
                      isBookmarked: state.bookmarkLabels[index],
                    ),
                  );
                } else if (state.bookmarks[index] is VideoMateri) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        VideoMateriDetailPage.routeName,
                        arguments: state.bookmarks[index],
                      ).then((value) {
                        context.read<BookmarkCubit>().getAllFromBookmark();
                      });
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: PublicoStaggeredTile(
                      tileIndex: index,
                      duration: state.bookmarks[index].duration,
                      title: state.bookmarks[index].title,
                      imageUrl: state.bookmarks[index].thumbnailUrl,
                      category: state.bookmarks[index].type,
                      isBookmarked: state.bookmarkLabels[index],
                    ),
                  );
                } else if (state.bookmarks[index] is VideoSingkat) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        VideoSingkatDetailPage.routeName,
                        arguments: state.bookmarks[index],
                      ).then((_) =>
                          context.read<BookmarkCubit>().getAllFromBookmark());
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: PublicoStaggeredTile(
                      tileIndex: index,
                      duration: state.bookmarks[index].duration,
                      title: state.bookmarks[index].title,
                      imageUrl: state.bookmarks[index].thumbnailUrl,
                      category: state.bookmarks[index].type,
                      isBookmarked: state.bookmarkLabels[index],
                    ),
                  );
                }
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      VideoSingkatDetailPage.routeName,
                      arguments: state.bookmarks[index],
                    ).then((_) =>
                        context.read<BookmarkCubit>().getAllFromBookmark());
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: PublicoStaggeredTile(
                    tileIndex: index,
                    sourcesCount: state.bookmarks[index].sources.length,
                    title: state.bookmarks[index].title,
                    imageUrl: state
                        .bookmarks[index].sources.first['illustrations'][0],
                    category: 'Infografis',
                    isBookmarked: state.bookmarkLabels[index],
                  ),
                );
              },
              staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 8.0,
            );
          } else {
            return Center(
              child: Text(
                'Belum ada bookmark yang tersedia',
                style: kTextTheme.bodyText2!.copyWith(color: kRichBlack),
              ),
            );
          }
        } else if (state is GetVideoMateriBookmarkSuccess) {
          if (state.videoMateriList.isNotEmpty) {
            return StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: state.videoMateriList.length,
              itemBuilder: (BuildContext itemContext, int index) => InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    VideoMateriDetailPage.routeName,
                    arguments: state.videoMateriList[index],
                  ).then((value) {
                    context.read<BookmarkCubit>().getVideoMateriFromBookmark();
                  });
                },
                borderRadius: BorderRadius.circular(10),
                child: PublicoStaggeredTile(
                  tileIndex: index,
                  duration: state.videoMateriList[index].duration,
                  title: state.videoMateriList[index].title,
                  imageUrl: state.videoMateriList[index].thumbnailUrl,
                  category: state.videoMateriList[index].type,
                  isBookmarked: state.videoMateriLabels[index],
                ),
              ),
              staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 8.0,
            );
          } else {
            return Center(
              child: Text(
                'Belum ada bookmark video materi yang tersedia',
                style: kTextTheme.bodyText2!.copyWith(color: kRichBlack),
              ),
            );
          }
        } else if (state is GetVideoSingkatBookmarkSuccess) {
          if (state.videoSingkatList.isNotEmpty) {
            return StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: state.videoSingkatList.length,
              itemBuilder: (BuildContext itemContext, int index) => InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    VideoSingkatDetailPage.routeName,
                    arguments: state.videoSingkatList[index],
                  ).then((value) {
                    context.read<BookmarkCubit>().getVideoSingkatFromBookmark();
                  });
                },
                borderRadius: BorderRadius.circular(10),
                child: PublicoStaggeredTile(
                  tileIndex: index,
                  duration: state.videoSingkatList[index].duration,
                  title: state.videoSingkatList[index].title,
                  imageUrl: state.videoSingkatList[index].thumbnailUrl,
                  category: state.videoSingkatList[index].type,
                  isBookmarked: state.videoSingkatLabels[index],
                ),
              ),
              staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 8.0,
            );
          } else {
            return Center(
              child: Text(
                'Belum ada bookmark video singkat yang tersedia',
                style: kTextTheme.bodyText2!.copyWith(color: kRichBlack),
              ),
            );
          }
        } else if (state is GetInfographicBookmarkSuccess) {
          if (state.infographicList.isNotEmpty) {
            return StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: state.infographicList.length,
              itemBuilder: (BuildContext itemContext, int index) => InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    InfographicsDetailPage.routeName,
                    arguments: state.infographicList[index],
                  ).then((value) {
                    context.read<BookmarkCubit>().getInfographicFromBookmark();
                  });
                },
                borderRadius: BorderRadius.circular(10),
                child: PublicoStaggeredTile(
                  tileIndex: index,
                  sourcesCount: state.infographicList[index].sources.length,
                  title: state.infographicList[index].title,
                  imageUrl: state
                      .infographicList[index].sources.first['illustrations'][0],
                  category: 'Infografis',
                  isBookmarked: state.infographicLabels[index],
                ),
              ),
              staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 8.0,
            );
          } else {
            return Center(
              child: Text(
                'Belum ada bookmark infografis yang tersedia',
                style: kTextTheme.bodyText2!.copyWith(color: kRichBlack),
              ),
            );
          }
        } else if (state is VideoMateriError) {
          return Center(
            child: Text(
              'Bookmark Error :(',
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
