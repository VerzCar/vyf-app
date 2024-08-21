import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/presentation/circle/cubit/circle_create_form_cubit.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class CreateCircleMembersForm extends StatelessWidget {
  const CreateCircleMembersForm({
    super.key,
    required this.onPrevious,
  });

  final VoidCallback onPrevious;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Public or private',
            style: themeData.textTheme.titleLarge,
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraint) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const _CirclePrivateInput(),
                        const SizedBox(height: 20.0),
                        Text(
                          helpText,
                          style: themeData.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 20.0),
                        BlocBuilder<CircleCreateFormCubit,
                            CircleCreateFormState>(
                          builder: (context, state) {
                            if (state.private.value) {
                              return _membersSelectionColumn(context);
                            }
                            return const SizedBox();
                          },
                        ),
                        const Spacer(),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor:
                                    themeData.colorScheme.secondary,
                              ),
                              onPressed: onPrevious,
                              child: const Text('Previous'),
                            ),
                            const SizedBox(width: 10),
                            BlocBuilder<CircleCreateFormCubit,
                                CircleCreateFormState>(
                              builder: (context, state) {
                                return SubmitButton(
                                  disabled: Formz.isPure([
                                        state.name,
                                        state.description,
                                        state.private,
                                      ]) ||
                                      state.status.isInProgress ||
                                      state.private.value,
                                  isLoading: state.status.isInProgress,
                                  foregroundColor:
                                      themeData.colorScheme.onSecondary,
                                  backgroundColor:
                                      themeData.colorScheme.secondary,
                                  label: 'Create',
                                  onPressed: () => context
                                      .read<CircleCreateFormCubit>()
                                      .onSubmit(),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String get helpText {
    return 'Choose whether your circle should be public or private. '
        'If it’s public (default), anyone can see and join the circle as a voter or candidate. '
        'If it’s private, you (the circle owner) will need to select the members, both voters and candidates. '
        'Only these selected members can interact with the circle and see it. You can change this members afterwards anytime.';
  }

  Widget _membersSelectionColumn(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Candidates',
                  style: themeData.textTheme.titleMedium,
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
                Text(
                  'Voters',
                  style: themeData.textTheme.titleMedium,
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
        return BlocProvider.value(
          value: BlocProvider.of<CircleCreateFormCubit>(context),
          child: BlocSelector<CircleCreateFormCubit, CircleCreateFormState,
              List<String>>(
            selector: (state) {
              if (type == MemberType.candidate) {
                return state.selectedMemberCandidateIds;
              }
              return state.selectedMemberVoterIds;
            },
            builder: (context, notSelectableUserIdentIds) {
              return UserSelectionSheet(
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
          ),
        );
      },
    );
  }
}

class _CirclePrivateInput extends StatefulWidget {
  const _CirclePrivateInput();

  @override
  State<_CirclePrivateInput> createState() => _CirclePrivateInputState();
}

class _CirclePrivateInputState extends State<_CirclePrivateInput> {
  final WidgetStateProperty<Icon?> _thumbIcon =
      WidgetStateProperty.resolveWith<Icon?>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const Icon(Icons.lock_outline);
      }
      return const Icon(Icons.lock_open_outlined);
    },
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CircleCreateFormCubit, CircleCreateFormState>(
      buildWhen: (previous, current) =>
          previous.private.value != current.private.value,
      builder: (context, state) {
        return SwitchListTile(
          title: state.private.value
              ? const Text('Private')
              : const Text('Public'),
          value: state.private.value,
          thumbIcon: _thumbIcon,
          onChanged: (bool value) {
            context.read<CircleCreateFormCubit>().onPrivateChanged(value);
          },
        );
      },
    );
  }
}
