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
  Timer? _debounce; // Timer for initiating the search after some delay

  // Method to change search query state and initate the search
  void changeSearchQuery(String newQuery, WidgetRef ref) {
    state = newQuery; // Change state

    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    if (state.isNotEmpty) {
      _debounce = Timer(const Duration(milliseconds: 1500), () async {
        ref
            .watch(giphyResponseStatusStateNotifierProvider.notifier)
            .changeResponseStatus(102); // Status for fetching data
        ref
            .read(giphyResponseDataStateNotifierProvider.notifier)
            .clearResponseData(); // Clearing of the old data
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

// StateNotifier for the HTTP Response data
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

// Initializing StateNotifier for the HTTP Response data
final giphyResponseDataStateNotifierProvider =
    StateNotifierProvider<GiphyResponseDataStateNotifier, List>((ref) {
  return GiphyResponseDataStateNotifier();
});

// StateNotifier for the HTTP Response code
class GiphyResponseStatusStateNotifier extends StateNotifier<int> {
  GiphyResponseStatusStateNotifier() : super(0);

  void changeResponseStatus(int newStatusCode) {
    state = newStatusCode;
  }
}

// Initializing StateNotifier for the HTTP Response code
final giphyResponseStatusStateNotifierProvider =
    StateNotifierProvider<GiphyResponseStatusStateNotifier, int>((ref) {
  return GiphyResponseStatusStateNotifier();
});

// Asynchronous method to initiate the search via GIPHY API
Future<void> initiateSearch(WidgetRef ref) async {
  final http.Response giphyResults;
  final String apiKey;
  final String querySearchRef = ref.read(giphySearchQueryStateNotifierProvider);
  final int currentExistingGifCount =
      ref.read(giphyResponseDataStateNotifierProvider).length;

  // Platform check (based on GIPHY API docs, 3 separate APIs needed)
  if (Platform.isIOS) {
    apiKey = dotenv.env["apiKeyIOS"].toString();
  } else if (Platform.isAndroid) {
    apiKey = dotenv.env["apiKeyAndroid"].toString();
  } else {
    apiKey = dotenv.env["apiKeyWeb"].toString();
  }

  try {
    giphyResults = await http.get(Uri.parse(
        "https://api.giphy.com/v1/gifs/search?api_key=$apiKey&limit=30&q=$querySearchRef&offset=$currentExistingGifCount&rating=pg-13"));

    // Change response code state
    ref
        .read(giphyResponseStatusStateNotifierProvider.notifier)
        .changeResponseStatus(giphyResults.statusCode);

    // Change response data state
    ref
        .watch(giphyResponseDataStateNotifierProvider.notifier)
        .changeResponseData(jsonDecode(giphyResults.body)["data"]);
  } on Exception catch (_) {
    // Change response code state to faulty to notify user about an error
    ref
        .read(giphyResponseStatusStateNotifierProvider.notifier)
        .changeResponseStatus(400);
  }
}
