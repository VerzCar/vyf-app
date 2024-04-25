import 'package:auto_route/auto_route.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(
          path: '/circle/:id',
          page: CircleRoute.page,
        ),
        AutoRoute(
          path: '/rankings/:id',
          page: RankingsRoute.page,
        ),
        // AutoRoute(page: SearchPage, initial: false),
        // AutoRoute(page: SettingsPage, initial: false),
        // AutoRoute(page: ProfilePage, initial: false),
        // CustomRoute(
        //     page: ProfileImagePage,
        //     transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
        //     durationInMilliseconds: 200),
        // CustomRoute(
        //     page: ProfileEditPage,
        //     transitionsBuilder: TransitionsBuilders.slideBottom,
        //     durationInMilliseconds: 200),
        // CustomRoute(
        //     page: ProfileEditImagePage,
        //     transitionsBuilder: TransitionsBuilders.fadeIn,
        //     durationInMilliseconds: 200),
        // AutoRoute(page: CameraPage, initial: false),
      ];
}
