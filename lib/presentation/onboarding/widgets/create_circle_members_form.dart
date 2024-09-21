import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class CreateCircleMembersForm extends StatelessWidget {
  const CreateCircleMembersForm({super.key, required this.onNext});

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraint) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.maxHeight),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: () => context.router.navigate(const HomeRoute()),
                  label: const Text('Skip'),
                  icon: const Icon(Icons.close),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: [
                      Text(
                        'Create your first Circle',
                        style: themeData.textTheme.headlineLarge,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Privacy & Members',
                        style: themeData.textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      const CreateCirclePrivateInput(),
                      const SizedBox(height: 5),
                      Text(
                        _helpText,
                        style: themeData.textTheme.bodySmall,
                      ),
                      const SizedBox(height: 30),
                      BlocBuilder<CircleCreateFormCubit, CircleCreateFormState>(
                        builder: (context, state) {
                          if (state.private.value) {
                            return _membersSelectionColumn(context);
                          }
                          return const SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Spacer(),
                Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: BlocBuilder<CircleCreateFormCubit,
                            CircleCreateFormState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor:
                                    themeData.colorScheme.onSecondary,
                                backgroundColor:
                                    themeData.colorScheme.secondary,
                              ),
                              onPressed: state.name.isValid &&
                                      state.description.isValid
                                  ? onNext
                                  : null,
                              child: const Text('Next'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _membersSelectionColumn(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      children: [
        Text(
          'Please select at least one candidate and voter for your circle.',
          style: themeData.textTheme.bodyMedium,
        ),
        const SizedBox(height: 5),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocSelector<UserOptionBloc, UserOptionState, int>(
                  selector: (state) =>
                      state.userOption.privateOption.maxCandidates,
                  builder: (context, maxCandidates) {
                    return BlocSelector<CircleCreateFormCubit,
                        CircleCreateFormState, List<String>>(
                      selector: (state) => state.selectedMemberCandidateIds,
                      builder: (context, ids) {
                        return Text(
                          'Candidates ${ids.length}/$maxCandidates',
                          style: themeData.textTheme.titleMedium,
                        );
                      },
                    );
                  },
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: themeData.colorScheme.secondary,
                  ),
                  onPressed: () =>
                      _showAddMembersSheet(context, MemberType.candidate),
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: BlocBuilder<CircleCreateFormCubit, CircleCreateFormState>(
                builder: (context, state) {
                  final selectedMemberCandidateIds =
                      state.selectedMemberCandidateIds;

                  return ListView.separated(
                    itemCount: selectedMemberCandidateIds.length,
                    itemBuilder: (BuildContext context, int index) {
                      final candidateId = selectedMemberCandidateIds[index];

                      return UserXProvider(
                        identityId: candidateId,
                        child: ListTile(
                          key: Key(candidateId),
                          leading: UserAvatar(
                            key: ValueKey(candidateId),
                          ),
                          title: BlocBuilder<UserXCubit, UserXState>(
                            builder: (context, state) {
                              return Text(state.user.displayName);
                            },
                          ),
                          trailing: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: themeData.colorScheme.error,
                            ),
                            onPressed: () => context
                                .read<CircleCreateFormCubit>()
                                .onRemoveFromSelectedMemberCandidateIds(
                                    candidateId),
                            child: const Icon(Icons.close),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const ListSeparator(),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocSelector<UserOptionBloc, UserOptionState, int>(
                  selector: (state) => state.userOption.privateOption.maxVoters,
                  builder: (context, maxVoters) {
                    return BlocSelector<CircleCreateFormCubit,
                        CircleCreateFormState, List<String>>(
                      selector: (state) => state.selectedMemberVoterIds,
                      builder: (context, ids) {
                        return Text(
                          'Voters ${ids.length}/$maxVoters',
                          style: themeData.textTheme.titleMedium,
                        );
                      },
                    );
                  },
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: themeData.colorScheme.secondary,
                  ),
                  onPressed: () =>
                      _showAddMembersSheet(context, MemberType.voter),
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: BlocBuilder<CircleCreateFormCubit, CircleCreateFormState>(
                builder: (context, state) {
                  final selectedMemberVoterIds = state.selectedMemberVoterIds;

                  return ListView.separated(
                    itemCount: selectedMemberVoterIds.length,
                    itemBuilder: (BuildContext context, int index) {
                      final voterId = selectedMemberVoterIds[index];

                      return UserXProvider(
                        identityId: voterId,
                        child: ListTile(
                          key: Key(voterId),
                          leading: UserAvatar(
                            key: ValueKey(voterId),
                          ),
                          title: BlocBuilder<UserXCubit, UserXState>(
                            builder: (context, state) {
                              return Text(state.user.displayName);
                            },
                          ),
                          trailing: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: themeData.colorScheme.error,
                            ),
                            onPressed: () => context
                                .read<CircleCreateFormCubit>()
                                .onRemoveFromSelectedMemberVoterIds(voterId),
                            child: const Icon(Icons.close),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const ListSeparator(),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showAddMembersSheet(BuildContext context, MemberType type) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (BuildContext context2) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: BlocProvider.of<CircleCreateFormCubit>(context),
            ),
            BlocProvider.value(
              value: BlocProvider.of<UserOptionBloc>(context),
            ),
          ],
          child: BlocSelector<CircleCreateFormCubit, CircleCreateFormState,
              List<String>>(
            selector: (state) {
              if (type == MemberType.candidate) {
                return state.selectedMemberCandidateIds;
              }
              return state.selectedMemberVoterIds;
            },
            builder: (context, notSelectableUserIdentIds) {
              return BlocSelector<UserOptionBloc, UserOptionState, int>(
                selector: (state) => type == MemberType.candidate
                    ? state.userOption.privateOption.maxCandidates
                    : state.userOption.privateOption.maxVoters,
                builder: (context, maxMembers) {
                  return UserSelectionSheet(
                      maxSelections: maxMembers,
                      notSelectableUserIdentIds: notSelectableUserIdentIds,
                      onAdd: (users) {
                        final usersIdentIds =
                            users.map((user) => user.identityId).toList();

                        if (type == MemberType.candidate) {
                          context
                              .read<CircleCreateFormCubit>()
                              .onAddToSelectedMemberCandidateIds(usersIdentIds);
                          context.router.maybePop();
                          return;
                        }

                        context
                            .read<CircleCreateFormCubit>()
                            .onAddToSelectedMemberVoterIds(usersIdentIds);
                        context.router.maybePop();
                        return;
                      });
                },
              );
            },
          ),
        );
      },
    );
  }

  String get _helpText {
    return 'Choose whether your circle should be public or private. '
        'If it’s public (default), anyone can see and join the circle as a voter or candidate. '
        'If it’s private, you (the circle owner) will need to select the members, both voters and candidates. '
        'Only these selected members can interact with the circle and see it. You can change members afterwards at anytime.';
  }
}
