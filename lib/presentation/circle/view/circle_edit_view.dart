import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/presentation/circle/cubit/circle_edit_form_cubit.dart';
import 'package:vote_your_face/presentation/circle/view/circle_edit_body.dart';
import 'package:vote_your_face/presentation/shared/widgets/snackbar/snackbar.dart';
import 'package:vote_your_face/theme.dart';

class CircleEditView extends StatelessWidget {
  const CircleEditView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Circle'),
        actions: [
          BlocConsumer<CircleEditFormCubit, CircleEditFormState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status.isSuccess) {
                BlocProvider.of<CircleBloc>(context).add(CircleUpdated(
                  circle: state.updatedCircle!,
                ));

                showSuccessSnackbar(
                  context,
                  'Saved successfully',
                );
              }

              if (state.status.isFailure) {
                showErrorSnackbar(
                  context,
                  'Could not save. Try again.',
                );
              }
            },
            builder: (context, state) {
              return TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: themeData.colorScheme.successColor,
                ),
                onPressed: Formz.isPure([
                  state.name,
                  state.description,
                  state.dateFrom,
                  state.timeFrom,
                  state.dateUntil,
                  state.timeUntil,
                ])
                    ? null
                    : () => context
                        .read<CircleEditFormCubit>()
                        .onSubmit(context.read<CircleBloc>().state.circle.id),
                child: const Text('Save'),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<CircleBloc, CircleState>(builder: (context, state) {
          switch (state.status) {
            case StatusIndicator.initial:
              return const Center(child: Text('initial Loading'));
            case StatusIndicator.loading:
              return const Center(child: CircularProgressIndicator());
            case StatusIndicator.success:
              return CircleEditBody(circle: state.circle);
            case StatusIndicator.failure:
              return const Center(child: Text('Error'));
          }
        }),
      ),
    );
  }
}
