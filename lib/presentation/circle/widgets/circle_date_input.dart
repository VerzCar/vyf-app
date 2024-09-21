import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/presentation/circle/cubit/circle_edit_form_cubit.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class CircleDateInput extends StatefulWidget {
  const CircleDateInput({
    super.key,
    required this.range,
    required this.onTap,
    this.initialValue,
  });

  final RangeSelection range;
  final VoidCallback onTap;
  final DateTime? initialValue;

  @override
  State<CircleDateInput> createState() => CircleDateInputState();
}

class CircleDateInputState extends State<CircleDateInput> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CircleEditFormCubit, CircleEditFormState>(
      buildWhen: buildWhen,
      builder: (context, state) {
        if (widget.range == RangeSelection.from) {
          _controller.text = state.dateFrom.value.isEmpty
              ? DateFormat.yMMMEd().format(
                  widget.initialValue ?? CircleDateFromInput.initialValue)
              : DateFormat.yMMMEd()
                  .format(DateTime.parse(state.dateFrom.value));
          return VyfTextFormField(
            key: Key('_CircleDateInput_Date${widget.range.toString()}Field'),
            controller: _controller,
            onTap: () => widget.onTap(),
            readOnly: true,
            textAlign: TextAlign.center,
            showError: !state.dateFrom.isPure && state.dateFrom.isNotValid,
            errorText: state.dateFrom.error.toString(),
          );
        }

        _controller.text = state.dateUntil.value.isEmpty
            ? widget.initialValue != null
                ? DateFormat.yMMMEd().format(widget.initialValue!)
                : '   infinite   '
            : DateFormat.yMMMEd().format(DateTime.parse(state.dateUntil.value));
        return VyfTextFormField(
          key: Key('_CircleDateInput_Date${widget.range.toString()}Field'),
          controller: _controller,
          onTap: () => widget.onTap(),
          readOnly: true,
          textAlign: TextAlign.center,
          showError: !state.dateUntil.isPure && state.dateUntil.isNotValid,
          errorText: state.dateUntil.error.toString(),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool buildWhen(
    CircleEditFormState previous,
    CircleEditFormState current,
  ) {
    return previous.dateFrom.value != current.dateFrom.value ||
        previous.dateUntil.value != current.dateUntil.value;
  }
}
