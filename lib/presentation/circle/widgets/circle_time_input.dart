import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/presentation/circle/cubit/circle_edit_form_cubit.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class CircleTimeInput extends StatefulWidget {
  const CircleTimeInput({
    super.key,
    required this.range,
    required this.onTap,
    this.initialValue,
  });

  final RangeSelection range;
  final VoidCallback onTap;
  final DateTime? initialValue;

  @override
  State<CircleTimeInput> createState() => _CircleTimeInputState();
}

class _CircleTimeInputState extends State<CircleTimeInput> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CircleEditFormCubit, CircleEditFormState>(
      buildWhen: buildWhen,
      builder: (context, state) {
        if (widget.range == RangeSelection.from) {
          _controller.text = state.timeFrom.value.isEmpty
              ? DateFormat.Hm().format(
                  widget.initialValue ?? CircleTimeFromInput.initialValue)
              : DateFormat.Hm().format(DateTime.parse(state.timeFrom.value));
          return VyfTextFormField(
            key: Key(
                'CreateCircleDurationForm_Time${widget.range.toString()}Field'),
            controller: _controller,
            onTap: () => widget.onTap(),
            readOnly: true,
            textAlign: TextAlign.center,
            showError: !state.timeFrom.isPure && state.timeFrom.isNotValid,
            errorText: state.timeFrom.error.toString(),
          );
        }

        _controller.text = state.timeUntil.value.isEmpty
            ? widget.initialValue != null
                ? DateFormat.Hm().format(widget.initialValue!)
                : '--:--'
            : DateFormat.Hm().format(DateTime.parse(state.timeUntil.value));
        return VyfTextFormField(
          key: Key(
              'CreateCircleDurationForm_Time${widget.range.toString()}Field'),
          controller: _controller,
          onTap: () => widget.onTap(),
          readOnly: true,
          textAlign: TextAlign.center,
          showError: !state.timeUntil.isPure && state.timeUntil.isNotValid,
          errorText: state.timeUntil.error.toString(),
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
    return previous.dateFrom != current.dateFrom ||
        previous.dateUntil != current.dateUntil ||
        previous.timeFrom != current.timeFrom ||
        previous.timeUntil != current.timeUntil;
  }
}
