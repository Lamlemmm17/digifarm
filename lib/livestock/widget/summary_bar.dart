import 'package:digifarm/livestock/widget/summary.dart';
import 'package:flutter/material.dart';

class SummaryBar extends StatefulWidget {
  const SummaryBar({super.key});

  @override
  State<SummaryBar> createState() => _SummaryBarState();
}

class _SummaryBarState extends State<SummaryBar> {
  final _pageController = PageController(
    initialPage: 1);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: 3,
      itemBuilder: (context, pageIndex) {
        return Summary(
          index: pageIndex);
      }
    );
  }
}
