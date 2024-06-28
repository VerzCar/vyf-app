import 'package:flutter/material.dart';
import 'package:vote_your_face/presentation/circles/view/circles_search_body.dart';

class CirclesSearchView extends StatelessWidget {
  const CirclesSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search circles'),
      ),
      body: const SafeArea(
        child: CirclesSearchBody(),
      ),
    );
  }
}
