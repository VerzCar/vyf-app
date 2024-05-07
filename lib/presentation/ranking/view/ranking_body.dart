import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circles/bloc/circles_bloc.dart';
import 'package:vote_your_face/application/circles/bloc/circles_bloc.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/ranking/widgets/ranking_sheet.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class RankingBody extends StatelessWidget {
  const RankingBody({super.key, required this.rankings});

  final List<Ranking> rankings;

  @override
  Widget build(BuildContext context) {
    
    Column(children: [
      Row(children: [
        Text('need a vote'),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Valid',
                style: themeData.textTheme.titleMedium,
              ),
            ),
            BlocBuilder<CirclesBloc, CirclesState>(
  builder: (context, state) {
    return TimeBox(
              from: state..validFrom,
              until: circle.validUntil,
            );
  },
),
          ],
        ),
      ],)
    ],)
    
    return rankings.isEmpty
        ? buildEmptyRankingsPlaceholder(context)
        : buildRankingListView(context);
  }

  ListView buildRankingListView(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);

    return ListView.separated(
      itemCount: rankings.length,
      itemBuilder: (BuildContext contextL, int index) {
        final ranking = rankings[index];
        late UserXCubit userXCubit;

        return Card(
          key: Key(ranking.id.toString()),
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          margin: const EdgeInsets.all(0),
          child: BlocProvider(
            create: (context) {
              userXCubit = UserXCubit(userRepository: sl<IUserRepository>())
                ..userXFetched(
                  context: context,
                  identityId: ranking.identityId,
                );
              return userXCubit;
            },
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 3.0,
              ),
              leading: Text(
                ranking.number.toString(),
                style: themeData.textTheme.bodyLarge,
              ),
              title: const UserAvatar(
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
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context2) {
                    return SizedBox(
                      height: size.height * 0.70,
                      child: BlocProvider.value(
                        value: userXCubit,
                        child: RankingSheet(
                          identityId: ranking.identityId,
                          placementNumber: ranking.number,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        height: 0,
      ),
    );
  }

  Widget buildEmptyRankingsPlaceholder(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/election-day.svg',
            semanticsLabel: 'Election day',
            width: size.width * 0.28,
            height: size.height * 0.28,
          ),
          const SizedBox(height: 15),
          Text(
            'No one has voted so far',
            style: themeData.textTheme.titleLarge,
          ),
          TextButton(
            style: themeData.textButtonTheme.style?.copyWith(
              foregroundColor:
                  MaterialStatePropertyAll(themeData.colorScheme.secondary),
            ),
            onPressed: () {},
            child: const Text('give a vote!'),
          ),
        ],
      ),
    );
  }
}
