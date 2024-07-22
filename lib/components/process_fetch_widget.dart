import 'package:flutter/material.dart';

class ProcessFetchComponent extends StatelessWidget {
  const ProcessFetchComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Image.asset(
          "assets/giphy-logo-loading.gif",
          scale: 0.60,
        ),
        const Text(
          'Fetching GIFs...',
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
