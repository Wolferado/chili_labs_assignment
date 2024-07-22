import 'package:chily_labs_assignment/models/giphy_gif_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

// StateNotifier for the Search Query
class GiphySearchQueryStateNotifier extends StateNotifier<String> {
  GiphySearchQueryStateNotifier() : super("");
  Timer? _debounce; // Timer for initiating search after some delay

  void changeSearchQuery(String newQuery, WidgetRef ref) {
    state = newQuery; // Change state

    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    if (state.isNotEmpty) {
      _debounce = Timer(const Duration(milliseconds: 1500), () async {
        ref
            .watch(giphyResponseStatusStateNotifierProvider.notifier)
            .changeResponseStatus(102);
        ref
            .read(giphyResponseDataStateNotifierProvider.notifier)
            .clearResponseData();
        initiateSearch(ref);
        _debounce?.cancel();
      });
    }
  }
}

// Initializing StateNotifier for the Search Query
final giphySearchQueryStateNotifierProvider =
    StateNotifierProvider<GiphySearchQueryStateNotifier, String>((ref) {
  return GiphySearchQueryStateNotifier();
});

class GiphyResponseDataStateNotifier extends StateNotifier<List<GiphyGif>> {
  GiphyResponseDataStateNotifier() : super(<GiphyGif>[]);

  void changeResponseData(List newResponseData) {
    for (int i = 0; i < newResponseData.length; i++) {
      state.add(GiphyGif.fromJson(newResponseData[i]));
    }
  }

  void clearResponseData() {
    state.clear();
  }
}

final giphyResponseDataStateNotifierProvider =
    StateNotifierProvider<GiphyResponseDataStateNotifier, List>((ref) {
  return GiphyResponseDataStateNotifier();
});

class GiphyResponseStatusStateNotifier extends StateNotifier<int> {
  GiphyResponseStatusStateNotifier() : super(0);

  void changeResponseStatus(int newStatusCode) {
    state = newStatusCode;
  }
}

final giphyResponseStatusStateNotifierProvider =
    StateNotifierProvider<GiphyResponseStatusStateNotifier, int>((ref) {
  return GiphyResponseStatusStateNotifier();
});

Future<void> initiateSearch(WidgetRef ref) async {
  final http.Response giphyResults;
  final String apiKey;
  final String querySearchRef = ref.read(giphySearchQueryStateNotifierProvider);
  final int currentExistingGifCount =
      ref.read(giphyResponseDataStateNotifierProvider).length;

  if (Platform.isIOS) {
    apiKey = dotenv.env["apiKeyIOS"].toString();
  } else if (Platform.isAndroid) {
    apiKey = dotenv.env["apiKeyAndroid"].toString();
  } else {
    apiKey = dotenv.env["apiKeyWeb"].toString();
  }

  try {
    giphyResults = await http.get(Uri.parse(
        "https://api.giphy.com/v1/gifs/search?api_key=$apiKey&limit=10&q=$querySearchRef&offset=$currentExistingGifCount&rating=pg-13"));

    // Change response code state
    ref
        .read(giphyResponseStatusStateNotifierProvider.notifier)
        .changeResponseStatus(giphyResults.statusCode);

    // Change response data state
    ref
        .watch(giphyResponseDataStateNotifierProvider.notifier)
        .changeResponseData(jsonDecode(giphyResults.body)["data"]);
  } on Exception catch (_) {
    // Change response code state
    ref
        .read(giphyResponseStatusStateNotifierProvider.notifier)
        .changeResponseStatus(400);
  }
}
