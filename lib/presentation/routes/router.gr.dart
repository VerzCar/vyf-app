// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:vote_your_face/presentation/circle/view/circle_page.dart'
    as _i1;
import 'package:vote_your_face/presentation/circles/view/circles_page.dart'
    as _i2;
import 'package:vote_your_face/presentation/home/view/home_page.dart' as _i3;
import 'package:vote_your_face/presentation/rankings/view/rankings_page.dart'
    as _i4;
import 'package:vote_your_face/presentation/settings/view/settings_page.dart'
    as _i5;
import 'package:vote_your_face/presentation/splash/view/splash_page.dart'
    as _i6;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    CircleRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CircleRouteArgs>(
          orElse: () =>
              CircleRouteArgs(circleId: pathParams.getInt('circleId')));
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.CirclePage(
          key: args.key,
          circleId: args.circleId,
        ),
      );
    },
    CirclesRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.CirclesPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    RankingsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RankingsRouteArgs>(
          orElse: () =>
              RankingsRouteArgs(circleId: pathParams.optInt('circleId')));
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.RankingsPage(
          key: args.key,
          circleId: args.circleId,
        ),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.SettingsPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.SplashPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.CirclePage]
class CircleRoute extends _i7.PageRouteInfo<CircleRouteArgs> {
  CircleRoute({
    _i8.Key? key,
    required int circleId,
    List<_i7.PageRouteInfo>? children,
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

  static const _i7.PageInfo<CircleRouteArgs> page =
      _i7.PageInfo<CircleRouteArgs>(name);
}

class CircleRouteArgs {
  const CircleRouteArgs({
    this.key,
    required this.circleId,
  });

  final _i8.Key? key;

  final int circleId;

  @override
  String toString() {
    return 'CircleRouteArgs{key: $key, circleId: $circleId}';
  }
}

/// generated route for
/// [_i2.CirclesPage]
class CirclesRoute extends _i7.PageRouteInfo<void> {
  const CirclesRoute({List<_i7.PageRouteInfo>? children})
      : super(
          CirclesRoute.name,
          initialChildren: children,
        );

  static const String name = 'CirclesRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i4.RankingsPage]
class RankingsRoute extends _i7.PageRouteInfo<RankingsRouteArgs> {
  RankingsRoute({
    _i8.Key? key,
    int? circleId,
    List<_i7.PageRouteInfo>? children,
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

  static const _i7.PageInfo<RankingsRouteArgs> page =
      _i7.PageInfo<RankingsRouteArgs>(name);
}

class RankingsRouteArgs {
  const RankingsRouteArgs({
    this.key,
    this.circleId,
  });

  final _i8.Key? key;

  final int? circleId;

  @override
  String toString() {
    return 'RankingsRouteArgs{key: $key, circleId: $circleId}';
  }
}

/// generated route for
/// [_i5.SettingsPage]
class SettingsRoute extends _i7.PageRouteInfo<void> {
  const SettingsRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.SplashPage]
class SplashRoute extends _i7.PageRouteInfo<void> {
  const SplashRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}
