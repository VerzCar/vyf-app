import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vote_your_face/presentation/rankings/view/rankings_view.dart';

@RoutePage()
class RankingsPage extends StatelessWidget {
  const RankingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RankingsView();
  }
}
