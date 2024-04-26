// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:vote_your_face/presentation/circle/view/circle_page.dart'
    as _i1;
import 'package:vote_your_face/presentation/circles/view/circles_page.dart'
    as _i2;
import 'package:vote_your_face/presentation/home/view/home_page.dart' as _i4;
import 'package:vote_your_face/presentation/rankings/view/rankings_page.dart'
    as _i5;
import 'package:vote_your_face/presentation/routes/router.dart' as _i3;
import 'package:vote_your_face/presentation/settings/view/settings_page.dart'
    as _i6;
import 'package:vote_your_face/presentation/splash/view/splash_page.dart'
    as _i7;

abstract class $AppRouter extends _i8.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    CircleRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CircleRouteArgs>(
          orElse: () =>
              CircleRouteArgs(circleId: pathParams.getInt('circleId')));
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.CirclePage(
          key: args.key,
          circleId: args.circleId,
        ),
      );
    },
    CirclesRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.CirclesPage(),
      );
    },
    CirclesTabRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.CirclesTabPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HomePage(),
      );
    },
    RankingsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RankingsRouteArgs>(
          orElse: () =>
              RankingsRouteArgs(circleId: pathParams.optInt('circleId')));
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.RankingsPage(
          key: args.key,
          circleId: args.circleId,
        ),
      );
    },
    RankingsTabRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.RankingsTabPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.SettingsPage(),
      );
    },
    SettingsTabRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.SettingsTabPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.SplashPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.CirclePage]
class CircleRoute extends _i8.PageRouteInfo<CircleRouteArgs> {
  CircleRoute({
    _i9.Key? key,
    required int circleId,
    List<_i8.PageRouteInfo>? children,
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

  static const _i8.PageInfo<CircleRouteArgs> page =
      _i8.PageInfo<CircleRouteArgs>(name);
}

class CircleRouteArgs {
  const CircleRouteArgs({
    this.key,
    required this.circleId,
  });

  final _i9.Key? key;

  final int circleId;

  @override
  String toString() {
    return 'CircleRouteArgs{key: $key, circleId: $circleId}';
  }
}

/// generated route for
/// [_i2.CirclesPage]
class CirclesRoute extends _i8.PageRouteInfo<void> {
  const CirclesRoute({List<_i8.PageRouteInfo>? children})
      : super(
          CirclesRoute.name,
          initialChildren: children,
        );

  static const String name = 'CirclesRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i3.CirclesTabPage]
class CirclesTabRoute extends _i8.PageRouteInfo<void> {
  const CirclesTabRoute({List<_i8.PageRouteInfo>? children})
      : super(
          CirclesTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'CirclesTabRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i5.RankingsPage]
class RankingsRoute extends _i8.PageRouteInfo<RankingsRouteArgs> {
  RankingsRoute({
    _i9.Key? key,
    int? circleId,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          RankingsRoute.name,
          args: RankingsRouteArgs(
            key: key,
            circleId: circleId,
          ),
          rawPathParams: {'circleId': circleId},
          initialChildren: children,
        );

  static const String name = 'RankingsRoute';

  static const _i8.PageInfo<RankingsRouteArgs> page =
      _i8.PageInfo<RankingsRouteArgs>(name);
}

class RankingsRouteArgs {
  const RankingsRouteArgs({
    this.key,
    this.circleId,
  });

  final _i9.Key? key;

  final int? circleId;

  @override
  String toString() {
    return 'RankingsRouteArgs{key: $key, circleId: $circleId}';
  }
}

/// generated route for
/// [_i3.RankingsTabPage]
class RankingsTabRoute extends _i8.PageRouteInfo<void> {
  const RankingsTabRoute({List<_i8.PageRouteInfo>? children})
      : super(
          RankingsTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'RankingsTabRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i6.SettingsPage]
class SettingsRoute extends _i8.PageRouteInfo<void> {
  const SettingsRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SettingsTabPage]
class SettingsTabRoute extends _i8.PageRouteInfo<void> {
  const SettingsTabRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SettingsTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsTabRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i7.SplashPage]
class SplashRoute extends _i8.PageRouteInfo<void> {
  const SplashRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}
