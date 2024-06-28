import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vote_your_face/presentation/circles/view/circles_search_view.dart';

@RoutePage()
class CirclesSearchPage extends StatelessWidget {
  const CirclesSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  const CirclesSearchView();
  }
}
