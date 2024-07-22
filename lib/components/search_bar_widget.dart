import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chily_labs_assignment/notifiers.dart';

// UI element for Search Bar
class GiphySearchBar extends ConsumerWidget {
  const GiphySearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(5.0),
      child: SearchBar(
        hintText: 'Search all the GIFs on Giphy',
        trailing: const <Widget>[
          Icon(
            Icons.search,
            size: 30.0,
          )
        ],
        onChanged: (value) {
          ref
              .read(giphySearchQueryStateNotifierProvider.notifier)
              .changeSearchQuery(value, ref);
        },
      ),
    );
  }
}
