import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/members/members.dart';
import 'package:vote_your_face/presentation/members/view/members_view.dart';

@RoutePage()
class MembersPage extends StatelessWidget {
  const MembersPage({super.key, @pathParam required this.circleId});

  final int circleId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CircleBloc, CircleState>(
      buildWhen: (prev, current) => prev.circle.id != current.circle.id,
      builder: (context, state) {
        return BlocProvider.value(
          value: BlocProvider.of<MembersBloc>(context)
            ..add(MembersInitialLoaded(
              circleId: circleId,
              currentCircleId: state.circle.id,
            )),
          child: const MembersView(),
        );
      },
    );
  }
}
