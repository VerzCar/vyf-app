import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/members/members.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/presentation/members/view/voters_body.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class VotersView extends StatelessWidget {
  const VotersView({super.key});

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
      child: const VotersBody(),
    );
  }
}
