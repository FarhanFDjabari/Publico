import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_storage/get_storage.dart';
import 'package:publico/domain/entities/theme.dart' as themeEntity;
import 'package:publico/presentation/bloc/infographic/infographic_cubit.dart';
import 'package:publico/presentation/pages/admin/post/infographic_post_page.dart';
import 'package:publico/presentation/pages/admin/post/post_theme_page.dart';
import 'package:publico/styles/colors.dart';
import 'package:publico/styles/text_styles.dart';

class InfographicsTab extends StatefulWidget {
  static const routeName = '/admin-infographics';
  const InfographicsTab({Key? key}) : super(key: key);

  @override
  _InfographicsTabState createState() => _InfographicsTabState();
}

class _InfographicsTabState extends State<InfographicsTab> {
  final _searchQueryController = TextEditingController();
  var themeClicked = false;

  @override
  Widget build(BuildContext context) {
    List<themeEntity.Theme> themeList = [];
    context
        .read<InfographicCubit>()
        .getInfographicThemesByUidFirestore(GetStorage().read('uid'));
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0.0),
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
              child: themeClicked
                  ? Container()
                  : BlocBuilder<InfographicCubit, InfographicState>(
                      builder: (context, state) {
                        if (state is GetInfographicThemesByUidSuccess) {
                          themeList = state.themeList;
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              childAspectRatio: 175 / 75,
                            ),
                            shrinkWrap: true,
                            itemCount: state.themeList.length,
                            itemBuilder: (_, index) => InkWell(
                              onTap: () {
                                setState(() => themeClicked = true);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  fit: StackFit.expand,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            state.themeList[index].imgPath,
                                        imageBuilder: (_, image) {
                                          return ColorFiltered(
                                            colorFilter: ColorFilter.mode(
                                              kRichBlack.withOpacity(0.45),
                                              BlendMode.darken,
                                            ),
                                            child: Image.network(
                                              state.themeList[index].imgPath,
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        },
                                        placeholder: (_, value) {
                                          return const SizedBox(
                                            height: 75,
                                            child: Center(
                                              child: SizedBox(
                                                width: 25,
                                                height: 25,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: kMikadoOrange,
                                                  strokeWidth: 3,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Center(
                                        child: Text(
                                          state.themeList[index].themeName,
                                          style: kTextTheme.caption!.copyWith(
                                            color: kRichWhite,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else if (state is GetInfographicThemesByUidError) {
                          return Center(
                            child: Text(state.message),
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
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        iconTheme: const IconThemeData(color: kRichWhite),
        backgroundColor: kMikadoOrange,
        spacing: 8,
        spaceBetweenChildren: 8,
        overlayColor: kRichBlack,
        children: [
          SpeedDialChild(
            backgroundColor: kRichWhite,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PostThemePage()),
              ).then(
                (_) => context
                    .read<InfographicCubit>()
                    .getInfographicThemesByUidFirestore(
                        GetStorage().read('uid')),
              );
            },
            child: const Icon(
              Icons.create_new_folder_outlined,
              color: kMikadoOrange,
            ),
            labelWidget: Container(
              margin: const EdgeInsets.only(right: 8),
              child: const Text('Tema'),
            ),
          ),
          SpeedDialChild(
            backgroundColor: kRichWhite,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => InfographicPostPage(
                          themes: themeList,
                        )),
              ).then(
                (_) => context
                    .read<InfographicCubit>()
                    .getInfographicThemesByUidFirestore(
                        GetStorage().read('uid')),
              );
            },
            child: const Icon(
              Icons.insights_outlined,
              color: kMikadoOrange,
            ),
            labelWidget: Container(
              margin: const EdgeInsets.only(right: 8),
              child: const Text('Infografis'),
            ),
          ),
        ],
      ),
    );
  }
}
