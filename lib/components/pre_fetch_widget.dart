import 'package:flutter/material.dart';
import 'svg_widget.dart';

class PreFetchComponent extends StatelessWidget {
  const PreFetchComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      children: [
        SVGWidget(assetName: 'assets/giphy-logo.svg'),
        Text(
          'Use the “Search” to look for some fresh GIFs from Giphy.',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0xFFBEBEBE),
              fontWeight: FontWeight.w600,
              fontSize: 20),
        )
      ],
    ));
  }
}
