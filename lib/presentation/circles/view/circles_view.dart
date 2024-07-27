import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circles/circles.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/presentation/circles/widgets/circles_of_interest.dart';
import 'package:vote_your_face/presentation/circles/widgets/open_invitations_sheet.dart';
import 'package:vote_your_face/presentation/circles/widgets/your_circles.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';
import 'package:vote_your_face/theme.dart';

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
          _commitmentNotificationAction(context),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () => context.router.push(const CirclesSearchRoute()),
              icon: const Icon(Icons.search_outlined),
            ),
          ),
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

  Widget _commitmentNotificationAction(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocSelector<CirclesBloc, CirclesState, List<CirclePaginated>>(
      selector: (state) => state.circlesOpenCommitments,
      builder: (context, circles) {
        if (circles.isEmpty) {
          return IconButton(
            onPressed: () => _showOpenInvitationsSheet(context),
            icon: const Icon(Icons.notifications_none_outlined),
          );
        }

        return Stack(
          children: [
            IconButton(
              onPressed: () => _showOpenInvitationsSheet(context),
              icon: Icon(
                Icons.notification_important_outlined,
                color: themeData.colorScheme.infoColor,
              ),
            ),
            Positioned(
              right: 2,
              top: 2,
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                  //borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  '${circles.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showOpenInvitationsSheet(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (BuildContext context2) {
        return const OpenInvitationsSheet();
      },
    );
  }
}
