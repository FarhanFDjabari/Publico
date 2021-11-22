import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:publico/presentation/bloc/search/search_cubit.dart';
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
                    {}
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
                  if (state is GetInfographicSearchSuccess) {
                    if (state.infographicList.isNotEmpty) {
                      return StaggeredGridView.countBuilder(
                        crossAxisCount: 4,
                        itemCount: state.infographicList.length,
                        itemBuilder: (BuildContext itemContext, int index) {
                          return InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(10),
                            child: PublicoStaggeredTile(
                              tileIndex: index,
                              duration: 2,
                              title: state.infographicList[index].title,
                              imageUrl: state.infographicList[index].sources
                                  .first['illustrations'][0],
                              sourcesCount: 1,
                              category: 'Infografis',
                            ),
                          );
                        },
                        staggeredTileBuilder: (int index) =>
                            const StaggeredTile.fit(2),
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 8.0,
                      );
                    }
                    return Center(
                      child: Text(
                        'Hasil pencarian tidak ditemukan',
                        style:
                            kTextTheme.bodyText1!.copyWith(color: kRichBlack),
                      ),
                    );
                  } else if (state is GetVideoMateriSearchSuccess) {
                    if (state.videoMateriList.isNotEmpty) {
                      return StaggeredGridView.countBuilder(
                        crossAxisCount: 4,
                        itemCount: state.videoMateriList.length,
                        itemBuilder: (BuildContext itemContext, int index) {
                          return InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(10),
                            child: PublicoStaggeredTile(
                              tileIndex: index,
                              duration: 2,
                              title: state.videoMateriList[index].title,
                              imageUrl:
                                  state.videoMateriList[index].thumbnailUrl,
                              sourcesCount:
                                  state.videoMateriList[index].duration,
                              category: state.videoMateriList[index].type,
                            ),
                          );
                        },
                        staggeredTileBuilder: (int index) =>
                            const StaggeredTile.fit(2),
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 8.0,
                      );
                    }
                    return Center(
                      child: Text(
                        'Hasil pencarian tidak ditemukan',
                        style:
                            kTextTheme.bodyText1!.copyWith(color: kRichBlack),
                      ),
                    );
                  } else if (state is GetVideoSingkatSearchSuccess) {
                    if (state.videoSingkatList.isNotEmpty) {
                      return StaggeredGridView.countBuilder(
                        crossAxisCount: 4,
                        itemCount: state.videoSingkatList.length,
                        itemBuilder: (BuildContext itemContext, int index) {
                          return InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(10),
                            child: PublicoStaggeredTile(
                              tileIndex: index,
                              duration: 2,
                              title: state.videoSingkatList[index].title,
                              imageUrl:
                                  state.videoSingkatList[index].thumbnailUrl,
                              sourcesCount:
                                  state.videoSingkatList[index].duration,
                              category: state.videoSingkatList[index].type,
                            ),
                          );
                        },
                        staggeredTileBuilder: (int index) =>
                            const StaggeredTile.fit(2),
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 8.0,
                      );
                    }
                    return Center(
                      child: Text(
                        'Hasil pencarian tidak ditemukan',
                        style:
                            kTextTheme.bodyText1!.copyWith(color: kRichBlack),
                      ),
                    );
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
