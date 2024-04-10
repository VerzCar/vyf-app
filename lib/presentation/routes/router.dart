import 'package:auto_route/auto_route.dart';
import 'package:vote_your_face/presentation/home/home.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {

  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    // AutoRoute(page: SplashPage, initial: true),
    // AutoRoute(page: LoginPage, initial: false),
    // AutoRoute(page: SignUpPage, initial: false),
    // AutoRoute(page: VerificationPage, initial: false),
    AutoRoute(page: HomePage.page, initial: false),
    // AutoRoute(
    //     path: '/circle-detail-page/:id',
    //     page: CircleDetailPage,
    //     initial: false),
    // AutoRoute(page: RankingListPage, initial: false),
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

