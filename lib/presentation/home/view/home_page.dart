import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


// @RoutePage()
// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthenticationBloc, AuthenticationState>(
//       listener: (context, state) {
//         if (state.status == AuthFlowStatus.unauthenticated) {
//           context.router.pushAndPopUntil(const LoginRoute(),
//               predicate: (Route<dynamic> route) => false);
//         }
//       },
//       child: MultiBlocProvider(
//         providers: [
//           BlocProvider(
//             create: (_) => HomeCubit(),
//           ),
//           BlocProvider(
//             create: (context) => sl<UserBloc>()..add(MetaUserDataRequested()),
//           ),
//         ],
//         child: const HomeView(),
//       ),
//     );
//   }
// }
