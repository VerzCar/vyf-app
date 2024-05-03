import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/members/view/members_view.dart';
import 'package:vote_your_face/application/members/members.dart';

@RoutePage()
class MembersPage extends StatelessWidget {
  const MembersPage({super.key, @pathParam required this.circleId});

  final int circleId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MembersBloc(
        voteCircleRepository: sl<IVoteCircleRepository>(),
      )..add(MembersInitialLoaded(circleId: circleId)),
      child: const MembersView(),
    );
  }
}
