// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:vote_your_face/presentation/circle/view/circle_page.dart'
    as _i1;
import 'package:vote_your_face/presentation/home/view/home_page.dart' as _i2;
import 'package:vote_your_face/presentation/rankings/view/rankings_page.dart'
    as _i3;
import 'package:vote_your_face/presentation/splash/view/splash_page.dart'
    as _i4;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    CircleRoute.name: (routeData) {
      final args = routeData.argsAs<CircleRouteArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.CirclePage(
          key: args.key,
          circleId: args.circleId,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    RankingsRoute.name: (routeData) {
      final args = routeData.argsAs<RankingsRouteArgs>(
          orElse: () => const RankingsRouteArgs());
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.RankingsPage(
          key: args.key,
          circleId: args.circleId,
        ),
      );
    },
    SplashRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SplashPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.CirclePage]
class CircleRoute extends _i5.PageRouteInfo<CircleRouteArgs> {
  CircleRoute({
    _i6.Key? key,
    required int circleId,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          CircleRoute.name,
          args: CircleRouteArgs(
            key: key,
            circleId: circleId,
          ),
          initialChildren: children,
        );

  static const String name = 'CircleRoute';

  static const _i5.PageInfo<CircleRouteArgs> page =
      _i5.PageInfo<CircleRouteArgs>(name);
}

class CircleRouteArgs {
  const CircleRouteArgs({
    this.key,
    required this.circleId,
  });

  final _i6.Key? key;

  final int circleId;

  @override
  String toString() {
    return 'CircleRouteArgs{key: $key, circleId: $circleId}';
  }
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.RankingsPage]
class RankingsRoute extends _i5.PageRouteInfo<RankingsRouteArgs> {
  RankingsRoute({
    _i6.Key? key,
    int? circleId,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          RankingsRoute.name,
          args: RankingsRouteArgs(
            key: key,
            circleId: circleId,
          ),
          initialChildren: children,
        );

  static const String name = 'RankingsRoute';

  static const _i5.PageInfo<RankingsRouteArgs> page =
      _i5.PageInfo<RankingsRouteArgs>(name);
}

class RankingsRouteArgs {
  const RankingsRouteArgs({
    this.key,
    this.circleId,
  });

  final _i6.Key? key;

  final int? circleId;

  @override
  String toString() {
    return 'RankingsRouteArgs{key: $key, circleId: $circleId}';
  }
}

/// generated route for
/// [_i4.SplashPage]
class SplashRoute extends _i5.PageRouteInfo<void> {
  const SplashRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
