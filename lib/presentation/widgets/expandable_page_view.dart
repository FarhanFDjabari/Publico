import 'package:flutter/material.dart';
import 'package:publico/presentation/widgets/size_reporting_widget.dart';

class ExpandablePageView extends StatefulWidget {
  final List<Widget> children;
  final ValueChanged<int> onPageChange;

  const ExpandablePageView({
    Key? key,
    required this.children,
    required this.onPageChange,
  }) : super(key: key);

  @override
  _ExpandablePageViewState createState() => _ExpandablePageViewState();
}

class _ExpandablePageViewState extends State<ExpandablePageView>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  List<double> _heights = [];
  int _currentPage = 0;

  double get _currentHeight => _heights[_currentPage];

  @override
  void initState() {
    _heights = widget.children.map((e) => 0.0).toList();
    super.initState();
    _pageController.addListener(() {
      final _newPage = _pageController.page!.round();
      if (_currentPage != _newPage) {
        setState(() => _currentPage = _newPage);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      curve: Curves.easeInOutCubic,
      duration: const Duration(milliseconds: 100),
      tween: Tween<double>(begin: _heights[0], end: _currentHeight),
      builder: (context, value, child) => SizedBox(height: value, child: child),
      child: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            if (!mounted) {
              return;
            }
            widget.onPageChange(index);
          });
        },
        children: _sizeReportingChildren
            .asMap() //
            .map((index, child) => MapEntry(index, child))
            .values
            .toList(),
      ),
    );
  }

  List<Widget> get _sizeReportingChildren => widget.children
      .asMap() //
      .map(
        (index, child) => MapEntry(
          index,
          OverflowBox(
            //needed, so that parent won't impose its constraints on the children, thus skewing the measurement results.
            minHeight: 0,
            maxHeight: double.infinity,
            alignment: Alignment.topCenter,
            child: SizeReportingWidget(
              onSizeChange: (size) {
                setState(() => _heights[index] = size.height);
              },
              child: Align(child: child),
            ),
          ),
        ),
      )
      .values
      .toList();
}
