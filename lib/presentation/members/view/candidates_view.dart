import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/members/members.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/presentation/members/view/candidates_body.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class CandidatesView extends StatelessWidget {
  const CandidatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MembersBloc, MembersState>(
      listener: (context, state) {
        // TODO: this will take any failed actions from members bloc
        //  we need more detailed error handling here
        if (state.status.isFailure) {
          EventTrigger.error(
            context: context,
            msg: 'Could not take action. Try again.',
          );
        }
      },
      child: const CandidatesBody(),
    );
  }
}
