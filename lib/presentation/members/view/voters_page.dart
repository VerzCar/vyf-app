import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/members/members.dart';
import 'package:vote_your_face/presentation/members/view/voters_view.dart';

@RoutePage()
class VotersPage extends StatelessWidget {
  const VotersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<MembersBloc>(context),
      child: const VotersView(),
    );
  }
}
