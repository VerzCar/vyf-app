import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';

class MembersView extends StatelessWidget {
  const MembersView({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: const [
        MembersCandidatesTabRoute(),
        MembersVotersTabRoute(),
      ],
      builder: (context, child, controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Members'),
            leading: const AutoLeadingButton(),
            bottom: TabBar(
              controller: controller,
              tabs: const [
                Tab(text: 'Candidates', icon: Icon(Icons.groups_outlined)),
                Tab(text: 'Voters', icon: Icon(Icons.group_outlined)),
              ],
            ),
          ),
          body: child,
        );
      },
    );
  }
}
