import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/presentation/circles/widgets/circles_of_interest.dart';
import 'package:vote_your_face/presentation/circles/widgets/your_circles.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

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
              child: UserXProvider(
                identityId: identityId,
                child: UserAvatar(
                  key: ValueKey(identityId),
                  option: const UserAvatarOption(size: AvatarSize.sm),
                ),
              ),
            );
          },
        ),
        title: const Text('Circles'),
        actions: [
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                onPressed: () =>
                    context.router.push(const CirclesSearchRoute()),
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, alignment: Alignment.centerRight),
                child: const Icon(Icons.search_outlined),
              ))
        ],
      ),
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            children: const [
              YourCircles(),
              CirclesOfInterest(),
            ],
          ),
        ),
      ),
    );
  }
}
