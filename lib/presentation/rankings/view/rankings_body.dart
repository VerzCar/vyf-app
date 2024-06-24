import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/presentation/rankings/cubit/rankings_cubit.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';

class RankingsBody extends StatelessWidget {
  const RankingsBody({
    super.key,
    required this.circles,
  });

  final List<Circle> circles;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () =>
              context.read<RankingsCubit>().viewedRankingsOfCircle(42),
          child: const Text('Vote'),
        ),
        circles.length > 0
            ? Expanded(
                child: _buildViewedRankingsListView(context),
              )
            : const SizedBox(
                width: 0,
                height: 0,
              ),
      ],
    );
  }

  ListView _buildViewedRankingsListView(BuildContext context) {
    final themeData = Theme.of(context);

    return ListView.separated(
      itemCount: circles.length,
      itemBuilder: (BuildContext contextListView, int index) {
        final circle = circles[index];

        return Card(
          key: Key(circle.id.toString()),
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          margin: const EdgeInsets.all(0),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 3.0,
            ),
            title: Text(
              circle.name,
              style: themeData.textTheme.titleMedium,
            ),
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            onTap: () => context.router.push(RankingRoute(circleId: circle.id)),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 15),
    );
  }
}
