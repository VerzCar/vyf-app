import 'package:auto_route/auto_route.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          initial: true,
        ),
        AutoRoute(
          path: '/',
          page: HomeRoute.page,
          children: [
            AutoRoute(
                path: 'circles',
                page: CirclesTabRoute.page,
                initial: true,
                children: [
                  AutoRoute(
                    path: '',
                    page: CirclesRoute.page,
                  ),
                  AutoRoute(
                    path: ':circleId',
                    page: CircleRoute.page,
                  ),
                  AutoRoute(
                    path: ':circleId/ranking',
                    page: RankingRoute.page,
                  ),
                  AutoRoute(
                    path: ':circleId/members',
                    page: MembersRoute.page,
                    children: [
                      AutoRoute(
                        path: '#candidates',
                        page: MembersCandidatesTabRoute.page,
                        children: [
                          AutoRoute(
                            path: '',
                            page: CandidatesRoute.page,
                            initial: true,
                          ),
                        ]
                      ),
                      AutoRoute(
                          path: '#voters',
                          page: MembersVotersTabRoute.page,
                          children: [
                            AutoRoute(
                              path: '',
                              page: VotersRoute.page,
                            ),
                          ]
                      ),
                    ],
                  ),
                ]),
            AutoRoute(
              path: 'rankings',
              page: RankingsTabRoute.page,
              children: [
                AutoRoute(
                  path: '',
                  page: RankingsRoute.page,
                ),
                AutoRoute(
                  path: ':circleId',
                  page: RankingRoute.page,
                ),
              ],
            ),
            AutoRoute(
              path: 'settings',
              page: SettingsTabRoute.page,
              children: [
                AutoRoute(
                  path: '',
                  page: SettingsRoute.page,
                ),
                AutoRoute(
                  path: 'user',
                  page: UserSettingsRoute.page,
                ),
                AutoRoute(
                  path: 'user/edit',
                  page: UserEditSettingsRoute.page,
                ),
              ],
            ),
          ],
        ),
      ];
}

@RoutePage()
class CirclesTabPage extends AutoRouter {
  const CirclesTabPage({super.key});
}

@RoutePage()
class RankingsTabPage extends AutoRouter {
  const RankingsTabPage({super.key});
}

@RoutePage()
class SettingsTabPage extends AutoRouter {
  const SettingsTabPage({super.key});
}

@RoutePage()
class MembersCandidatesTabPage extends AutoRouter {
  const MembersCandidatesTabPage({super.key});
}

@RoutePage()
class MembersVotersTabPage extends AutoRouter {
  const MembersVotersTabPage({super.key});
}
