import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circle/bloc/circle_bloc.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/circles/bloc/circles_bloc.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/circle/cubit/circle_edit_form_cubit.dart';
import 'package:vote_your_face/presentation/circle/view/circle_edit_view.dart';

@RoutePage()
class CircleEditPage extends StatelessWidget {
  const CircleEditPage({super.key, @pathParam required this.circleId});

  final int circleId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
            value: BlocProvider.of<CircleBloc>(context)
              ..add(CircleSelected(circleId: circleId))),
        BlocProvider.value(value: BlocProvider.of<CirclesBloc>(context)),
        BlocProvider(
          create: (context) => CircleEditFormCubit(
            voteCircleRepository: sl<IVoteCircleRepository>(),
          ),
        )
      ],
      child: const CircleEditView(),
    );
  }
}
