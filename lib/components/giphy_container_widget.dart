import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chily_labs_assignment/notifiers.dart';
import 'package:chily_labs_assignment/components/fail_fetch_widget.dart';
import 'package:chily_labs_assignment/components/pre_fetch_widget.dart';
import 'package:chily_labs_assignment/components/process_fetch_widget.dart';
import 'package:chily_labs_assignment/components/success_fetch_widget.dart';

class GiphyContainer extends ConsumerWidget {
  const GiphyContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(giphyResponseStatusStateNotifierProvider) == 0) {
      return const PreFetchComponent();
    } else if (ref.watch(giphyResponseStatusStateNotifierProvider) == 102) {
      return const ProcessFetchComponent();
    } else if (ref.watch(giphyResponseStatusStateNotifierProvider) == 200) {
      List data = ref.read(giphyResponseDataStateNotifierProvider);
      return SuccessFetchComponent(data, ref);
    } else {
      int responseCode = ref.read(giphyResponseStatusStateNotifierProvider);
      return FailFetchComponent(responseCode);
    }
  }
}
