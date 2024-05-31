import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/presentation/circle/cubit/circle_create_form_cubit.dart';

class CreateCircleMembersForm extends StatelessWidget {
  const CreateCircleMembersForm({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  final VoidCallback onNext;
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
            'The circle should have a descriptive naming, to indicate for what the circle stands for. This gives you the ability to give a first hint for what the circle is for.',
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
              BlocBuilder<CircleCreateFormCubit, CircleCreateFormState>(
                builder: (context, state) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: themeData.colorScheme.onSecondary,
                        backgroundColor: themeData.colorScheme.secondary),
                    onPressed: state.private.value ? null : onNext,
                    child: const Text('Next'),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _CirclePrivateInput extends StatefulWidget {
  const _CirclePrivateInput({super.key});

  @override
  State<_CirclePrivateInput> createState() => __CirclePrivateInputState();
}

class __CirclePrivateInputState extends State<_CirclePrivateInput> {
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
      buildWhen: (previous, current) => previous.private.value != current.private.value,
      builder: (context, state) {
        return SwitchListTile(
          title: state.private.value ? const Text('Private') : const Text('Public'),
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
