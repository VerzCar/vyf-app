import 'package:flutter/material.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/presentation/user-avatar/view/user_avatar_view.dart';

class RankingBody extends StatelessWidget {
  const RankingBody({super.key, required this.rankings});

  final List<Ranking> rankings;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.builder(
        itemCount: rankings.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            key: Key(rankings[index].id.toString()),
            width: 50,
            height: 50,
            margin: const EdgeInsets.only(bottom: 7.0),
            child: Row(
              children: [
                Text(
                  rankings[index].number.toString(),
                  style: themeData.textTheme.labelLarge,
                ),
                const SizedBox(width: 10.0),
                UserAvatar(
                  identityId: rankings[index].identityId,
                  option: UserAvatarOption(
                    withLabel: true,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => {},
                  style: themeData.elevatedButtonTheme.style?.copyWith(
                    backgroundColor:
                        MaterialStatePropertyAll(themeData.colorScheme.secondary),
                    foregroundColor:
                    MaterialStatePropertyAll(themeData.colorScheme.onSecondary),
                  ),
                  child: const Text('Vote'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
