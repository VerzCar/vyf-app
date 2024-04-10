// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vote_your_face/presentation/circle_detail/view/circle_detail_page.dart';
// import 'package:vote_your_face/presentation/home/cubit/home_cubit.dart';
// import 'package:vote_your_face/presentation/profile/profile.dart';
// import 'package:vote_your_face/presentation/search/search.dart';
//
// class HomeView extends StatelessWidget {
//   const HomeView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);
//
//     return Scaffold(
//       body: IndexedStack(
//         index: selectedTab.index,
//         children: const [
//           CircleDetailPage(
//             id: 0,
//           ),
//           SearchPage(),
//           ProfilePage()
//         ],
//       ),
//       bottomNavigationBar: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             _HomeTabButton(
//               groupValue: selectedTab,
//               value: HomeTab.circleDetail,
//               icon: const Icon(Icons.list_outlined),
//               activeIcon: const Icon(Icons.view_list),
//             ),
//             _HomeTabButton(
//               groupValue: selectedTab,
//               value: HomeTab.search,
//               icon: const Icon(Icons.person_search_outlined),
//               activeIcon: const Icon(Icons.person_search),
//             ),
//             _HomeTabButton(
//               groupValue: selectedTab,
//               value: HomeTab.profile,
//               icon: const Icon(Icons.person_outline),
//               activeIcon: const Icon(Icons.person),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _HomeTabButton extends StatelessWidget {
//   const _HomeTabButton({
//     Key? key,
//     required this.groupValue,
//     required this.value,
//     required this.icon,
//     required this.activeIcon,
//   }) : super(key: key);
//
//   final HomeTab groupValue;
//   final HomeTab value;
//   final Widget icon;
//   final Widget activeIcon;
//
//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       onPressed: () => context.read<HomeCubit>().setTab(value),
//       iconSize: 32,
//       color: Theme.of(context).colorScheme.primary,
//       icon: groupValue != value ? icon : activeIcon,
//     );
//   }
// }
