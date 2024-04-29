import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        CirclesTabRoute(),
        RankingsTabRoute(),
        SettingsTabRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) {
              if (tabsRouter.activeIndex == index) {
                tabsRouter.maybePopTop();
              }
              tabsRouter.setActiveIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                key: Key('circlesTab'),
                label: 'Circles',
                icon: Icon(Icons.circle_outlined),
                activeIcon: Icon(Icons.blur_circular_outlined),
              ),
              BottomNavigationBarItem(
                  key: Key('rankingsTab'),
                  label: 'Rankings',
                  icon: Icon(Icons.list),
                  activeIcon: Icon(Icons.list_alt_outlined)),
              BottomNavigationBarItem(
                  key: Key('settingsTab'),
                  label: 'Settings',
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person)),
            ],
          ),
        );
      },
    );
  }
}
