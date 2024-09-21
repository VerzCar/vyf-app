import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/circle/circle.dart';

class CreateCirclePrivateInput extends StatefulWidget {
  const CreateCirclePrivateInput({super.key});

  @override
  State<CreateCirclePrivateInput> createState() =>
      _CreateCirclePrivateInputState();
}

class _CreateCirclePrivateInputState extends State<CreateCirclePrivateInput> {
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
