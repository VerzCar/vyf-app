import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:vote_your_face/application/circles/bloc/circles_bloc.dart';
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

    return Container(
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
          const _CirclePrivateInput(),
          const SizedBox(height: 20.0),
          Text(
            helpText,
            style: themeData.textTheme.bodyMedium,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: themeData.colorScheme.secondary,
                ),
                onPressed: onPrevious,
                child: const Text('Previous'),
              ),
              const SizedBox(width: 10),
              BlocConsumer<CircleCreateFormCubit, CircleCreateFormState>(
                listenWhen: (previous, current) =>
                    previous.status != current.status,
                listener: (context, state) {
                  if (state.status.isSuccess) {
                    BlocProvider.of<CirclesBloc>(context).add(CirclesCreated(
                      circle: state.createdCircle!,
                    ));

                    showSuccessSnackbar(
                      context,
                      'Circle ${state.createdCircle!.name} created',
                    );
                    context.router.maybePop();
                  }

                  if (state.status.isFailure) {
                    showErrorSnackbar(
                      context,
                      'Could not create circle. Try again.',
                    );
                  }
                },
                builder: (context, state) {
                  return SubmitButton(
                    disabled: Formz.isPure([
                      state.name,
                      state.description,
                      state.private,
                    ]) ||
                        state.status.isInProgress || state.private.value,
                    isLoading: state.status.isInProgress,
                    foregroundColor: themeData.colorScheme.onSecondary,
                    backgroundColor: themeData.colorScheme.secondary,
                    label: 'Create',
                    onPressed: () =>
                        context.read<CircleCreateFormCubit>().onSubmit(),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  String get helpText {
    return 'Choose whether your circle should be public or private. '
        'If it’s public (default), anyone can see and join the circle as a voter or candidate. '
        'If it’s private, you (the circle owner) will need to select the members, both voters and candidates. '
        'Only these selected members can interact with the circle and see it.';
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
