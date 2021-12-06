import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:publico/domain/entities/infographic.dart';
import 'package:publico/domain/entities/video_materi.dart';
import 'package:publico/domain/entities/video_singkat.dart';
import 'package:publico/presentation/bloc/search/search_cubit.dart';
import 'package:publico/presentation/pages/detail/infographics_detail_page.dart';
import 'package:publico/presentation/pages/detail/video_materi_detail_page.dart';
import 'package:publico/presentation/pages/detail/video_singkat_detail_page.dart';
import 'package:publico/presentation/widgets/chip_button.dart';
import 'package:publico/presentation/widgets/publico_staggered_tile.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search';
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchQueryController = TextEditingController();
  int _selectedIndex = 0;

  @override
  void dispose() {
    super.dispose();
    _searchQueryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (_selectedIndex) {
      case 0:
        {
          context
              .read<SearchCubit>()
              .getAllFromSearch(_searchQueryController.text.toLowerCase());
        }
        break;
      case 1:
        {
          context.read<SearchCubit>().getInfographicFromSearch(
              _searchQueryController.text.toLowerCase());
        }
        break;
      case 2:
        {
          context.read<SearchCubit>().getVideoMateriFromSearch(
              _searchQueryController.text.toLowerCase());
        }
        break;
      case 3:
        {
          context.read<SearchCubit>().getVideoSingkatFromSearch(
              _searchQueryController.text.toLowerCase());
        }
        break;
    }
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
                hintText: 'Individu dan pemerintah',
                hintStyle: kTextTheme.bodyText2!.copyWith(
                  color: kLightGrey,
                ),
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
              onSubmitted: (value) {
                switch (_selectedIndex) {
                  case 0:
                    {
                      context.read<SearchCubit>().getAllFromSearch(
                          _searchQueryController.text.toLowerCase());
                    }
                    break;
                  case 1:
                    {
                      context.read<SearchCubit>().getInfographicFromSearch(
                          _searchQueryController.text.toLowerCase());
                    }
                    break;
                  case 2:
                    {
                      context.read<SearchCubit>().getVideoMateriFromSearch(
                          _searchQueryController.text.toLowerCase());
                    }
                    break;
                  case 3:
                    {
                      context.read<SearchCubit>().getVideoSingkatFromSearch(
                          _searchQueryController.text.toLowerCase());
                    }
                    break;
                }
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is GetAllSearchSuccess) {
                    if (state.allList == []) {
                      return Center(
                        child: Text(
                          'Hasil pencarian tidak ditemukan',
                          style:
                              kTextTheme.bodyText1!.copyWith(color: kRichBlack),
                        ),
                      );
                    } else {
                      return StaggeredGridView.countBuilder(
                        crossAxisCount: 4,
                        itemCount: state.allList.length,
                        itemBuilder: (BuildContext itemContext, int index) {
                          final imageUrl = state.allList[index] is Infographic
                              ? state.allList[index].sources
                                  .first['illustrations'][0]
                              : state.allList[index].thumbnailUrl;
                          final sourceCount =
                              state.allList[index] is Infographic
                                  ? state.allList[index].sources.length
                                  : state.allList[index].duration;
                          return InkWell(
                            onTap: () {
                              if (state.allList[index] is Infographic) {
                                Navigator.pushNamed(
                                  context,
                                  InfographicsDetailPage.routeName,
                                  arguments: state.allList[index],
                                );
                              } else if (state.allList[index] is VideoMateri) {
                                Navigator.pushNamed(
                                  context,
                                  VideoMateriDetailPage.routeName,
                                  arguments: state.allList[index],
                                );
                              } else if (state.allList[index] is VideoSingkat) {
                                Navigator.pushNamed(
                                  context,
                                  VideoSingkatDetailPage.routeName,
                                  arguments: state.allList[index],
                                );
                              }
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: PublicoStaggeredTile(
                              tileIndex: index,
                              duration: 2,
                              title: state.allList[index].title,
                              imageUrl: imageUrl,
                              sourcesCount: sourceCount,
                              category: state.allList[index].type,
                              isBookmarked: state.itemLabel[index],
                            ),
                          );
                        },
                        staggeredTileBuilder: (int index) =>
                            const StaggeredTile.fit(2),
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 8.0,
                      );
                    }
                  } else if (state is GetInfographicSearchSuccess) {
                    if (state.infographicList == []) {
                      return Center(
                        child: Text(
                          'Hasil pencarian tidak ditemukan',
                          style:
                              kTextTheme.bodyText1!.copyWith(color: kRichBlack),
                        ),
                      );
                    } else {
                      return StaggeredGridView.countBuilder(
                        crossAxisCount: 4,
                        itemCount: state.infographicList.length,
                        itemBuilder: (BuildContext itemContext, int index) {
                          return InkWell(
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
                              duration: 2,
                              title: state.infographicList[index].title,
                              imageUrl: state.infographicList[index].sources
                                  .first['illustrations'][0],
                              sourcesCount:
                                  state.infographicList[index].sources.length,
                              category: 'Infografis',
                              isBookmarked: state.infographicLabel[index],
                            ),
                          );
                        },
                        staggeredTileBuilder: (int index) =>
                            const StaggeredTile.fit(2),
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 8.0,
                      );
                    }
                  } else if (state is GetVideoMateriSearchSuccess) {
                    if (state.videoMateriList == []) {
                      return Center(
                        child: Text(
                          'Hasil pencarian tidak ditemukan',
                          style:
                              kTextTheme.bodyText1!.copyWith(color: kRichBlack),
                        ),
                      );
                    } else {
                      return StaggeredGridView.countBuilder(
                        crossAxisCount: 4,
                        itemCount: state.videoMateriList.length,
                        itemBuilder: (BuildContext itemContext, int index) {
                          return InkWell(
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
                              imageUrl:
                                  state.videoMateriList[index].thumbnailUrl,
                              sourcesCount: 0,
                              category: state.videoMateriList[index].type,
                              isBookmarked: state.videoMateriLabel[index],
                            ),
                          );
                        },
                        staggeredTileBuilder: (int index) =>
                            const StaggeredTile.fit(2),
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 8.0,
                      );
                    }
                  } else if (state is GetVideoSingkatSearchSuccess) {
                    if (state.videoSingkatList == []) {
                      return Center(
                        child: Text(
                          'Hasil pencarian tidak ditemukan',
                          style:
                              kTextTheme.bodyText1!.copyWith(color: kRichBlack),
                        ),
                      );
                    } else {
                      return StaggeredGridView.countBuilder(
                        crossAxisCount: 4,
                        itemCount: state.videoSingkatList.length,
                        itemBuilder: (BuildContext itemContext, int index) {
                          return InkWell(
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
                              imageUrl:
                                  state.videoSingkatList[index].thumbnailUrl,
                              sourcesCount: 0,
                              category: state.videoSingkatList[index].type,
                              isBookmarked: state.videoSingkatLabel[index],
                            ),
                          );
                        },
                        staggeredTileBuilder: (int index) =>
                            const StaggeredTile.fit(2),
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 8.0,
                      );
                    }
                  } else if (state is SearchError) {
                    return Center(
                      child: Text(
                        'Kesalahan Koneksi: ${state.message}',
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
