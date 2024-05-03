import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/application/members/members.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class CandidatesView extends StatelessWidget {
  const CandidatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MembersBloc, MembersState>(
      builder: (context, state) {
        final candidates = state.circleCandidate.candidates;

        return ListView.separated(
          itemCount: candidates.length,
          itemBuilder: (BuildContext context, int index) {
            final candidate = candidates[index];
            late UserXCubit userXCubit;

            return Card(
              key: Key(candidate.id.toString()),
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
                      identityId: candidate.candidate,
                    );
                  return userXCubit;
                },
                child: const ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 3.0,
                  ),
                  leading: UserAvatar(
                    option: UserAvatarOption(
                      withLabel: true,
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(
            height: 0,
          ),
        );
      },
    );
  }
}
