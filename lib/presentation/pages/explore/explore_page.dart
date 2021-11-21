import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:publico/domain/entities/infographic.dart';
import 'package:publico/domain/entities/video_materi.dart';
import 'package:publico/presentation/bloc/explore/cubit/explore_cubit.dart';
import 'package:publico/presentation/pages/detail/infographics_detail_page.dart';
import 'package:publico/presentation/pages/detail/video_materi_detail_page.dart';
import 'package:publico/presentation/pages/detail/video_singkat_detail_page.dart';
import 'package:publico/presentation/widgets/publico_staggered_tile.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class ExplorePage extends StatefulWidget {
  static const routeName = '/explore';
  const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    context.read<ExploreCubit>().getExploreData();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: BlocBuilder<ExploreCubit, ExploreState>(
          builder: (context, state) {
            if (state is ExploreSuccess) {
              if (state.exploreList.isNotEmpty) {
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  itemCount: state.exploreList.length,
                  itemBuilder: (BuildContext itemContext, int index) {
                    if (state.exploreList[index] is Infographic) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            InfographicsDetailPage.routeName,
                            arguments: state.exploreList[index],
                          );
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: PublicoStaggeredTile(
                          tileIndex: index,
                          title: state.exploreList[index].title,
                          imageUrl: state.exploreList[index].sources
                              .first['illustrations'][0],
                          sourcesCount: state.exploreList[index].sources.length,
                          category: 'Infografis',
                        ),
                      );
                    } else if (state.exploreList[index] is VideoMateri) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            VideoMateriDetailPage.routeName,
                            arguments: state.exploreList[index],
                          );
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: PublicoStaggeredTile(
                          tileIndex: index,
                          duration: state.exploreList[index].duration,
                          title: state.exploreList[index].title,
                          imageUrl: state.exploreList[index].thumbnailUrl,
                          category: state.exploreList[index].type,
                        ),
                      );
                    }
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          VideoSingkatDetailPage.routeName,
                          arguments: state.exploreList[index],
                        );
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: PublicoStaggeredTile(
                        tileIndex: index,
                        duration: state.exploreList[index].duration,
                        title: state.exploreList[index].title,
                        imageUrl: state.exploreList[index].thumbnailUrl,
                        category: state.exploreList[index].type,
                      ),
                    );
                  },
                  staggeredTileBuilder: (int index) =>
                      const StaggeredTile.fit(2),
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 8.0,
                );
              } else {
                return Center(
                  child: Text(
                    'Belum ada post yang tersedia',
                    style: kTextTheme.bodyText2!.copyWith(color: kRichBlack),
                  ),
                );
              }
            } else if (state is ExploreError) {
              return Center(
                child: Text(
                  'Kesalahan Koneksi: ${state.message}',
                  style: kTextTheme.bodyText2!.copyWith(color: kRichBlack),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
