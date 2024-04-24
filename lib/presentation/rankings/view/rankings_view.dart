import 'package:flutter/material.dart';

class RankingsView extends StatelessWidget {
  const RankingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ranking'),
      ),
      body: const SafeArea(
        child: Text('it works'),
      ),
    );
  }
}
