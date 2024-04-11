import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/authentication/authentication.dart';
import 'package:vote_your_face/presentation/home/cubit/home_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: [
          Placeholder(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Circles'),
                  TextButton(
                    onPressed: () => {
                      context
                          .read<AuthenticationBloc>()
                          .add(AuthenticationLogoutRequested())
                    },
                    child: const Text('Sign out'),
                  )
                ],
              ),
            ),
          ),
          const Placeholder(
            child: Center(
              child: Text('Rankings'),
            ),
          ),
          const Placeholder(
            child: Center(
              child: Text('Users'),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.circleDetail,
              icon: const Icon(Icons.circle_outlined),
              activeIcon: const Icon(Icons.blur_circular_outlined),
            ),
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.search,
              icon: const Icon(Icons.list),
              activeIcon: const Icon(Icons.list_alt_outlined),
            ),
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.profile,
              icon: const Icon(Icons.person_outline),
              activeIcon: const Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton({
    super.key,
    required this.groupValue,
    required this.value,
    required this.icon,
    required this.activeIcon,
  });

  final HomeTab groupValue;
  final HomeTab value;
  final Widget icon;
  final Widget activeIcon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<HomeCubit>().setTab(value),
      iconSize: 32,
      color: Theme.of(context).colorScheme.primary,
      icon: groupValue != value ? icon : activeIcon,
    );
  }
}
