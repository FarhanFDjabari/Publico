import 'package:flutter/material.dart';
import 'package:publico/presentation/pages/bookmark/bookmark_content.dart';
import 'package:publico/presentation/widgets/chip_button.dart';

class BookmarkPage extends StatefulWidget {
  static const routeName = '/bookmark';
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
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
            Expanded(
                child: BookmarkContent(
              selectedBookmark: _selectedIndex,
            )),
          ],
        ),
      ),
    );
  }
}
