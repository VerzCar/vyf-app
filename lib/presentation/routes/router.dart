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
