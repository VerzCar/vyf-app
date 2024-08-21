import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/circle/bloc/circle_bloc.dart';
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
                      BlocSelector<CircleBloc, CircleState, bool>(
                        selector: (state) => state.circle.private,
                        builder: (context, isPrivateCircle) {
                          return BlocBuilder<UserOptionBloc, UserOptionState>(
                            builder: (context, state) {
                              return BlocBuilder<MembersBloc, MembersState>(
                                builder: (context, membersState) {
                                  final maxCandidates = isPrivateCircle
                                      ? state.userOption.privateOption
                                          .maxCandidates
                                      : state.userOption.maxCandidates;
                                  return Text(
                                      '${membersState.circleCandidate.candidates.length}/$maxCandidates');
                                },
                              );
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
                      BlocSelector<CircleBloc, CircleState, bool>(
                        selector: (state) => state.circle.private,
                        builder: (context, isPrivateCircle) {
                          return BlocBuilder<UserOptionBloc, UserOptionState>(
                            builder: (context, state) {
                              return BlocBuilder<MembersBloc, MembersState>(
                                builder: (context, membersState) {
                                  final maxVoters = isPrivateCircle
                                      ? state.userOption.privateOption.maxVoters
                                      : state.userOption.maxVoters;
                                  return Text(
                                      '${membersState.circleVoter.voters.length}/$maxVoters');
                                },
                              );
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
