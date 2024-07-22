import 'package:flutter/material.dart';
import 'svg_widget.dart';

const Map<int, String> errorCodes = {
  400: "Error occured - 400.\nBad request.",
  401: "Error occured - 401.\nSomething is wrong with credentials.",
  403: "Error occured - 403.\nSomething is wrong with API key.",
  404: "Error occured - 404.\nGIFs not found.",
  414: "Error occured - 411.\nSearch query is longer than 50 characters.",
  429: "Error occured - 429.\nToo many requests, try again in 1 hour."
};

class FailFetchComponent extends StatelessWidget {
  final int responseCode;
  const FailFetchComponent(this.responseCode, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SVGWidget(assetName: 'assets/giphy-logo-error.svg'),
        Text(
          '${errorCodes[responseCode]}',
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Color(0xFFBEBEBE),
              fontWeight: FontWeight.w600,
              fontSize: 20),
        )
      ],
    ));
  }
}
