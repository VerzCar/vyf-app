import 'package:flutter/material.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/presentation/user_avatar/view/user_avatar_view.dart';

import 'package:vote_your_face/presentation/shared/shared.dart';

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
          return Card.outlined(
            key: Key(rankings[index].id.toString()),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              leading: Text(
                rankings[index].number.toString(),
                style: themeData.textTheme.labelLarge,
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
                  foregroundColor: MaterialStatePropertyAll(
                      themeData.colorScheme.onSecondary),
                ),
                child: const Text('Vote'),
              ),
              onTap: () => {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'Placement: ${rankings[index].number}',
                              style: themeData.textTheme.headlineSmall,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Center(
                            child: UserAvatar(
                              identityId: rankings[index].identityId,
                              option: UserAvatarOption(
                                size: AvatarSize.xl,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            'Why vote me',
                            style: themeData.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'vote me',
                            style: themeData.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 15.0),
                          Text(
                            'Bio',
                            style: themeData.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'bio...',
                            style: themeData.textTheme.bodyMedium,
                          ),
                          const Divider(),
                        ],
                      ),
                    );
                  },
                ),
              },
            ),
          );
        },
      ),
    );
  }
}
