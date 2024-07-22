import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SVGWidget extends StatelessWidget {
  const SVGWidget({super.key, required this.assetName});

  final String assetName;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.all(5.0),
        child:
            SvgPicture.asset(assetName, semanticsLabel: assetName, width: 100));
  }
}
