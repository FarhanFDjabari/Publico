import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:publico/presentation/bloc/infographic/infographic_cubit.dart';
import 'package:publico/presentation/widgets/chip_button.dart';
import 'package:publico/presentation/widgets/publico_staggered_tile.dart';
import 'package:publico/presentation/widgets/publico_staggered_tile_admin.dart';
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
              onChanged: (value) {},
              onSubmitted: (value) {
                switch (_selectedIndex) {
                  case 0:
                    {}
                    break;
                  case 1:
                    {
                      context.read<InfographicCubit>().getInfographicPosts(
                          _searchQueryController.text.toLowerCase());
                    }
                    break;
                  case 2:
                    {}
                    break;
                  case 3:
                    {}
                    break;
                  default:
                    {}
                    break;
                }
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<InfographicCubit, InfographicState>(
                builder: (context, state) {
                  if (state is GetInfographicsByQuerySuccess) {
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
                  } else if (state is InfographicError) {
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
