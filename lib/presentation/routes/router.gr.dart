// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;
import 'package:vote_your_face/presentation/circle/view/circle_page.dart'
    as _i1;
import 'package:vote_your_face/presentation/circles/view/circles_page.dart'
    as _i2;
import 'package:vote_your_face/presentation/home/view/home_page.dart' as _i4;
import 'package:vote_your_face/presentation/ranking/view/ranking_page.dart'
    as _i5;
import 'package:vote_your_face/presentation/rankings/view/rankings_page.dart'
    as _i6;
import 'package:vote_your_face/presentation/routes/router.dart' as _i3;
import 'package:vote_your_face/presentation/settings/view/settings_page.dart'
    as _i7;
import 'package:vote_your_face/presentation/splash/view/splash_page.dart'
    as _i8;

abstract class $AppRouter extends _i9.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    CircleRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CircleRouteArgs>(
          orElse: () =>
              CircleRouteArgs(circleId: pathParams.getInt('circleId')));
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.CirclePage(
          key: args.key,
          circleId: args.circleId,
        ),
      );
    },
    CirclesRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.CirclesPage(),
      );
    },
    CirclesTabRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.CirclesTabPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HomePage(),
      );
    },
    RankingRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RankingRouteArgs>(
          orElse: () =>
              RankingRouteArgs(circleId: pathParams.getInt('circleId')));
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.RankingPage(
          key: args.key,
          circleId: args.circleId,
        ),
      );
    },
    RankingsRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.RankingsPage(),
      );
    },
    RankingsTabRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.RankingsTabPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.SettingsPage(),
      );
    },
    SettingsTabRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.SettingsTabPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.SplashPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.CirclePage]
class CircleRoute extends _i9.PageRouteInfo<CircleRouteArgs> {
  CircleRoute({
    _i10.Key? key,
    required int circleId,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          CircleRoute.name,
          args: CircleRouteArgs(
            key: key,
            circleId: circleId,
          ),
          rawPathParams: {'circleId': circleId},
          initialChildren: children,
        );

  static const String name = 'CircleRoute';

  static const _i9.PageInfo<CircleRouteArgs> page =
      _i9.PageInfo<CircleRouteArgs>(name);
}

class CircleRouteArgs {
  const CircleRouteArgs({
    this.key,
    required this.circleId,
  });

  final _i10.Key? key;

  final int circleId;

  @override
  String toString() {
    return 'CircleRouteArgs{key: $key, circleId: $circleId}';
  }
}

/// generated route for
/// [_i2.CirclesPage]
class CirclesRoute extends _i9.PageRouteInfo<void> {
  const CirclesRoute({List<_i9.PageRouteInfo>? children})
      : super(
          CirclesRoute.name,
          initialChildren: children,
        );

  static const String name = 'CirclesRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i3.CirclesTabPage]
class CirclesTabRoute extends _i9.PageRouteInfo<void> {
  const CirclesTabRoute({List<_i9.PageRouteInfo>? children})
      : super(
          CirclesTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'CirclesTabRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i9.PageRouteInfo<void> {
  const HomeRoute({List<_i9.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i5.RankingPage]
class RankingRoute extends _i9.PageRouteInfo<RankingRouteArgs> {
  RankingRoute({
    _i10.Key? key,
    required int circleId,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          RankingRoute.name,
          args: RankingRouteArgs(
            key: key,
            circleId: circleId,
          ),
          rawPathParams: {'circleId': circleId},
          initialChildren: children,
        );

  static const String name = 'RankingRoute';

  static const _i9.PageInfo<RankingRouteArgs> page =
      _i9.PageInfo<RankingRouteArgs>(name);
}

class RankingRouteArgs {
  const RankingRouteArgs({
    this.key,
    required this.circleId,
  });

  final _i10.Key? key;

  final int circleId;

  @override
  String toString() {
    return 'RankingRouteArgs{key: $key, circleId: $circleId}';
  }
}

/// generated route for
/// [_i6.RankingsPage]
class RankingsRoute extends _i9.PageRouteInfo<void> {
  const RankingsRoute({List<_i9.PageRouteInfo>? children})
      : super(
          RankingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'RankingsRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i3.RankingsTabPage]
class RankingsTabRoute extends _i9.PageRouteInfo<void> {
  const RankingsTabRoute({List<_i9.PageRouteInfo>? children})
      : super(
          RankingsTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'RankingsTabRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i7.SettingsPage]
class SettingsRoute extends _i9.PageRouteInfo<void> {
  const SettingsRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SettingsTabPage]
class SettingsTabRoute extends _i9.PageRouteInfo<void> {
  const SettingsTabRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SettingsTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsTabRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SplashPage]
class SplashRoute extends _i9.PageRouteInfo<void> {
  const SplashRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}
