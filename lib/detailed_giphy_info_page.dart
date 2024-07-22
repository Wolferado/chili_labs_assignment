import 'package:chily_labs_assignment/models/giphy_gif_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailedGiphyPage extends StatelessWidget {
  final GiphyGif detailedGiphy;
  const DetailedGiphyPage(this.detailedGiphy, {super.key});

  final TextStyle headingFontStyle = const TextStyle(
    color: Color(0xFEFFFFFF),
    fontWeight: FontWeight.bold,
    fontSize: 22.0,
  );
  final TextStyle contentFontStyle = const TextStyle(
    color: Color(0xFEFFFFFF),
    fontSize: 18.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            foregroundColor: const Color(0xFEFFFFFF),
            backgroundColor: const Color(0xFF121212),
            title: const Text(
              "GIF Information",
            )),
        backgroundColor: const Color(0xFF121212),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.all(10),
            child: Column(children: [
              Image.network(detailedGiphy.originalVideoUrl),
              Text("Title:", style: headingFontStyle),
              Text(detailedGiphy.title, style: contentFontStyle),
              Text("Available from:", style: headingFontStyle),
              InkWell(
                  child: Text(detailedGiphy.url, style: contentFontStyle),
                  onTap: () async {
                    await launchUrl(Uri.parse(detailedGiphy.url));
                  }),
              Text("Author username:", style: headingFontStyle),
              Text(detailedGiphy.username, style: contentFontStyle),
              Text("Created:", style: headingFontStyle),
              Text(detailedGiphy.createdDate, style: contentFontStyle)
            ]),
          ),
        ));
  }
}
