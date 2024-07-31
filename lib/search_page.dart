import 'package:chily_labs_assignment/components/giphy_container_widget.dart';
import 'package:chily_labs_assignment/components/search_bar_widget.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: Wrap(
        children: [GiphySearchBar(), GiphyContainer()],
      ),
      backgroundColor: Color(0xFF121212),
    ));
  }
}
