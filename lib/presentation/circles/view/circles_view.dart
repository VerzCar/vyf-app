import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/user/bloc/user_bloc.dart';
import 'package:vote_your_face/presentation/circles/widgets/circles_of_interest.dart';
import 'package:vote_your_face/presentation/circles/widgets/your_circles.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';
import 'package:vote_your_face/presentation/user_avatar/models/models.dart';
import 'package:vote_your_face/presentation/user_avatar/view/user_avatar_view.dart';

class CirclesView extends StatelessWidget {
  const CirclesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BlocSelector<UserBloc, UserState, String>(
          selector: (state) => state.user.identityId,
          builder: (context, identityId) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: UserAvatar(
                identityId: identityId,
                option: UserAvatarOption(size: AvatarSize.xs),
              ),
            );
          },
        ),
        title: const Text('Circles'),
        actions: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.search_outlined),
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: const [
            YourCircles(),
            CirclesOfInterest(),
          ],
        ),
      ),
    );
  }
}
