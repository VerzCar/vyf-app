import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/circles/bloc/circles_bloc.dart'
    as circles_bloc;
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/presentation/circle/cubit/circle_edit_form_cubit.dart';
import 'package:vote_your_face/presentation/circle/view/circle_edit_body.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: _submitActionButton(themeData),
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

  Widget _submitActionButton(ThemeData themeData) {
    return BlocConsumer<CircleEditFormCubit, CircleEditFormState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSuccessful) {
          BlocProvider.of<circles_bloc.CirclesBloc>(context)
              .add(circles_bloc.CirclesUpdated(
            circle: state.updatedCircle!,
          ));

          final circleRankingBloc = BlocProvider.of<CircleRankingBloc>(context);
          final circleBloc = BlocProvider.of<CircleBloc>(context);

          circleBloc.add(CircleUpdated(circle: state.updatedCircle!));

          if (circleRankingBloc.state.circle.id == circleBloc.state.circle.id) {
            circleRankingBloc
                .add(CircleRankingUpdated(circle: state.updatedCircle!));
          }

          EventTrigger.success(
            context: context,
            msg: 'Saved successfully',
          );
        }

        if (state.status.isDeletedSuccessful) {
          BlocProvider.of<circles_bloc.CirclesBloc>(context)
              .add(circles_bloc.CirclesDeleted(
            circleId: state.deletedCircleId!,
          ));

          EventTrigger.success(
            context: context,
            msg: 'Deleted circle successfully',
          );
          context.router.navigate(const CirclesRoute());
        }

        if (state.status.isFailure) {
          EventTrigger.error(
            context: context,
            msg: 'Could not save. Try again.',
          );
        }
      },
      builder: (context, state) {
        return SubmitButton(
          disabled: Formz.isPure([
                state.name,
                state.description,
                state.dateFrom,
                state.timeFrom,
                state.dateUntil,
                state.timeUntil,
              ]) ||
              state.status.isLoading,
          isLoading: state.status.isLoading,
          foregroundColor: themeData.colorScheme.successColor,
          onPressed: () => context
              .read<CircleEditFormCubit>()
              .onSubmit(context.read<CircleBloc>().state.circle.id),
        );
      },
    );
  }
}
