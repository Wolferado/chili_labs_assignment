import 'package:chily_labs_assignment/detailed_giphy_info_page.dart';
import 'package:chily_labs_assignment/notifiers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GiphyScrollPositionStateNotifier extends StateNotifier<int> {
  GiphyScrollPositionStateNotifier() : super(0);

  void changePositionValue(int newPositionValue) {
    state = newPositionValue;
  }
}

class SuccessFetchComponent extends ConsumerStatefulWidget {
  final List data;
  final WidgetRef ref;
  const SuccessFetchComponent(this.data, this.ref, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SuccessFetchComponentState();
}

class _SuccessFetchComponentState extends ConsumerState<SuccessFetchComponent> {
  final scrollController = ScrollController();
  List responseData = [];

  @override
  void initState() {
    super.initState();
    initiateSearch(widget.ref);
    responseData = widget.data;

    scrollController.addListener(() {
      if (scrollController.offset + 50 >
          scrollController.position.maxScrollExtent) {
        initiateSearch(widget.ref);
        setState(() {
          responseData = widget.data;
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    OrientationBuilder gridContainer =
        OrientationBuilder(builder: (context, orientation) {
      return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
            mainAxisSpacing: 24,
            crossAxisSpacing: 12,
          ),
          controller: scrollController,
          itemCount: responseData.length,
          itemBuilder: (context, index) {
            Image gifToLoad;

            if (responseData[index].downsizedVideoUrl != "Unknown") {
              gifToLoad = Image.network(responseData[index].downsizedVideoUrl);
            } else {
              gifToLoad = Image.network(responseData[index].originalVideoUrl);
            }

            return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DetailedGiphyPage(responseData[index])));
                },
                child: gifToLoad);
          });
    });

    return Center(
        child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width * 0.8,
            child: gridContainer));
  }
}
