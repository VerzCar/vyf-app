import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/circle/cubit/circle_member_cubit.dart';

class CircleMemberActionSheet extends StatelessWidget {
  const CircleMemberActionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          child: Text(
            'Member Actions',
            style: themeData.textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 10),
        BlocProvider(
          create: (context) => CircleMemberCubit(
            voteCircleRepository: sl<IVoteCircleRepository>(),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return ListTile(
                  leading: const Icon(Icons.group_add_outlined),
                  title: const Text('Join as candidate'),
                  onTap: () =>
                      context.read<CircleMemberCubit>().onJoinAsCandidate(
                            context.read<CircleBloc>().state.circle.id,
                          ),
                );
              }
              if (index == 1) {
                return ListTile(
                  leading: const Icon(Icons.add_task_outlined),
                  title: const Text('Join as voter'),
                  onTap: () => context.read<CircleMemberCubit>().onJoinAsVoter(
                        context.read<CircleBloc>().state.circle.id,
                      ),
                );
              }
              return null;
            },
            separatorBuilder: (context, index) => const Divider(
              height: 0,
            ),
          ),
        ),
      ],
    );
  }
}
