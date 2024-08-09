import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/members/members.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/members/view/candidates_view.dart';

import '../cubit/candidates_select_cubit.dart';

@RoutePage()
class CandidatesPage extends StatelessWidget {
  const CandidatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: BlocProvider.of<MembersBloc>(context),
        ),
        BlocProvider(
          create: (BuildContext ctx) => CandidatesSelectCubit(
            voteCircleRepository: sl<IVoteCircleRepository>(),
          ),
        ),
      ],
      child: const CandidatesView(),
    );
  }
}
