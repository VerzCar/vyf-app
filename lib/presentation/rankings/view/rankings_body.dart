import 'package:flutter/material.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/presentation/user-avatar/view/user_avatar_view.dart';

class RankingsBody extends StatelessWidget {
  const RankingsBody({super.key, required this.rankings});

  final List<Ranking> rankings;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.builder(
        itemCount: rankings.length,
        itemBuilder: (BuildContext context, int index) {
          return UserAvatar(
            identityId: rankings[index].identityId,
            //option: UserAvatarOption(size: AvatarSize.xs),
          );
        },
      ),
    );
  }
}
