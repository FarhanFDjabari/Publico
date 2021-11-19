import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:publico/presentation/pages/detail/infographics_detail_page.dart';
import 'package:publico/presentation/widgets/publico_staggered_tile.dart';

class ExplorePage extends StatefulWidget {
  static const routeName = '/explore';
  const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: 12,
          itemBuilder: (BuildContext itemContext, int index) => InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                InfographicsDetailPage.routeName,
                arguments: 'secret',
              );
            },
            borderRadius: BorderRadius.circular(10),
            child: PublicoStaggeredTile(
              tileIndex: index,
              title:
                  'Subsidi Pemerintah dan Bantuan untuk lorem ipsum asdaksdka sdass dasdasdas',
              imageUrl:
                  'https://marketplace.canva.com/EADaooG1kwk/2/0/704w/canva-top-major-south-america-commodities-_IBpJMSh0_Y.jpg',
              category: 'Infografis',
            ),
          ),
          staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 8.0,
        ),
      ),
    );
  }
}
