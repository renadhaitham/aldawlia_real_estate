import 'package:flutter/material.dart';

class DawliaLogo extends StatelessWidget {
  const DawliaLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'lib/assets/images/Al-Dawlia_logo_20230.png',
      ),
    );
  }
}

class DfsLogo extends StatelessWidget {
  const DfsLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'lib/assets/images/DFS.png',
      ),
    );
  }
}
