import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/members/members.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';

class MembersView extends StatelessWidget {
  const MembersView({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: const [
        MembersCandidatesTabRoute(),
        MembersVotersTabRoute(),
      ],
      builder: (context, child, controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Members'),
            leading: const AutoLeadingButton(),
            bottom: TabBar(
              controller: controller,
              tabs: [
                Tab(
                  icon: const Icon(Icons.groups_outlined),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Candidates'),
                      BlocBuilder<UserOptionBloc, UserOptionState>(
                        builder: (context, state) {
                          return BlocBuilder<MembersBloc, MembersState>(
                            builder: (context, membersState) {
                              return Text(
                                  '${membersState.circleCandidate.candidates.length}/${state.userOption.maxCandidates}');
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Tab(
                  icon: const Icon(Icons.group_outlined),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Voters'),
                      BlocBuilder<UserOptionBloc, UserOptionState>(
                        builder: (context, state) {
                          return BlocBuilder<MembersBloc, MembersState>(
                            builder: (context, membersState) {
                              return Text(
                                  '${membersState.circleVoter.voters.length}/${state.userOption.maxVoters}');
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: child,
        );
      },
    );
  }
}
