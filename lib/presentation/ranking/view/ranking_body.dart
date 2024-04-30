import 'package:flutter/material.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/presentation/ranking/widgets/ranking_sheet.dart';
import 'package:vote_your_face/presentation/user_avatar/view/user_avatar_view.dart';

import 'package:vote_your_face/presentation/shared/shared.dart';

class RankingBody extends StatelessWidget {
  const RankingBody({super.key, required this.rankings});

  final List<Ranking> rankings;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return ListView.separated(
      itemCount: rankings.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          key: Key(rankings[index].id.toString()),
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
            leading: Text(
              rankings[index].number.toString(),
              style: themeData.textTheme.bodyLarge,
            ),
            title: UserAvatar(
              identityId: rankings[index].identityId,
              option: UserAvatarOption(
                withLabel: true,
              ),
            ),
            trailing: ElevatedButton(
              onPressed: () => {},
              style: themeData.elevatedButtonTheme.style?.copyWith(
                backgroundColor:
                    MaterialStatePropertyAll(themeData.colorScheme.secondary),
                foregroundColor:
                    MaterialStatePropertyAll(themeData.colorScheme.onSecondary),
              ),
              child: const Text('Vote'),
            ),
            onTap: () => {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return RankingSheet(
                    identityId: rankings[index].identityId,
                    placementNumber: rankings[index].number,
                  );
                },
              ),
            },
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        height: 0,
      ),
    );
  }
}
