import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/rankings/bloc/rankings_bloc.dart';
import 'package:vote_your_face/presentation/user-avatar/view/user_avatar_view.dart';

class RankingsBody extends StatelessWidget {
  const RankingsBody({super.key, this.circle});

  final Circle? circle;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RankingsBloc, RankingsState>(builder: (context, state) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          itemCount: state.rankings.length,
          itemBuilder: (BuildContext context, int index) {
            return UserAvatar(
              identityId: state.rankings[index].identityId,
              //option: UserAvatarOption(size: AvatarSize.xs),
            );
          },
        ),
      );
    });
  }
}
