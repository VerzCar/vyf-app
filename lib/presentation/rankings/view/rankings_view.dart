import 'package:flutter/material.dart';
import 'package:vote_your_face/presentation/rankings/view/rankings_body.dart';

class RankingsView extends StatelessWidget {
  const RankingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rankings'),
      ),
      body: const SafeArea(
        child: RankingsBody(),
      ),
    );
  }
}
