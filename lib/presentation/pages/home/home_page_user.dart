import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:publico/presentation/pages/bookmark/bookmark_page.dart';
import 'package:publico/presentation/pages/explore/explore_page.dart';
import 'package:publico/presentation/pages/search/search_page.dart';
import 'package:publico/styles/colors.dart';

class HomePageUser extends StatefulWidget {
  static const routeName = '/home-user';
  const HomePageUser({Key? key}) : super(key: key);

  @override
  _HomePageUserState createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  int _selectedIndex = 0;
  bool _visible = true;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  final pages = [
    const ExplorePage(),
    const SearchPage(),
    const BookmarkPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.forward) {
            if (!_visible) {
              setState(() => _visible = true);
            }
          } else if (notification.direction == ScrollDirection.reverse) {
            if (_visible) {
              setState(() => _visible = false);
            }
          }
          return true;
        },
        child: PageView(
          children: pages,
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _visible
          ? Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(32),
              color: kRichWhite,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.65,
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          _pageController.animateToPage(
                            0,
                            duration: const Duration(milliseconds: 550),
                            curve: Curves.easeOut,
                          );
                        },
                        icon: Icon(
                          Icons.explore,
                          size: 30,
                          color: _selectedIndex == 0
                              ? kMikadoOrange
                              : kLightOrange,
                        ),
                      ),
                      IconButton(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          _pageController.animateToPage(
                            1,
                            duration: const Duration(milliseconds: 550),
                            curve: Curves.easeOut,
                          );
                        },
                        icon: Icon(
                          Icons.search,
                          size: 30,
                          color: _selectedIndex == 1
                              ? kMikadoOrange
                              : kLightOrange,
                        ),
                      ),
                      IconButton(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          _pageController.animateToPage(
                            2,
                            duration: const Duration(milliseconds: 550),
                            curve: Curves.easeOut,
                          );
                        },
                        icon: Icon(
                          Icons.bookmark,
                          size: 30,
                          color: _selectedIndex == 2
                              ? kMikadoOrange
                              : kLightOrange,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
    );
  }
}