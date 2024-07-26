import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/circles/circles.dart';
import 'package:vote_your_face/theme.dart';

class OpenInvitationsSheet extends StatelessWidget {
  const OpenInvitationsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          child: Text(
            'Open invitations',
            style: themeData.textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 10),
        BlocBuilder<CirclesBloc, CirclesState>(
          builder: (context, state) {
            final circles = state.circlesOpenCommitments;

            if (circles.isEmpty) {
              return const Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('You have no open invitations.'),
                ],
              ));
            }

            return Expanded(
              child: ListView.separated(
                  itemCount: circles.length,
                  itemBuilder: (BuildContext context, int index) {
                    final circle = circles[index];

                    return Card(
                      key: Key(circle.id.toString()),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      margin: const EdgeInsets.all(0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(child: Text(circle.name)),
                            IconButton(
                              onPressed: () => {},
                              style: IconButton.styleFrom(
                                  foregroundColor:
                                      themeData.colorScheme.whiteColor,
                                  backgroundColor: themeData.colorScheme.error),
                              icon: const Icon(Icons.close),
                            ),
                            IconButton(
                              onPressed: () => {},
                              style: IconButton.styleFrom(
                                  foregroundColor:
                                      themeData.colorScheme.whiteColor,
                                  backgroundColor:
                                      themeData.colorScheme.successColor),
                              icon: const Icon(Icons.check),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                        height: 0,
                        thickness: 3,
                        color: themeData.colorScheme.blackColor,
                      )),
            );
          },
        ),
      ],
    );
  }
}
