// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;
import 'package:vote_your_face/presentation/circle/view/circle_page.dart'
    as _i2;
import 'package:vote_your_face/presentation/circles/view/circles_page.dart'
    as _i3;
import 'package:vote_your_face/presentation/home/view/home_page.dart' as _i5;
import 'package:vote_your_face/presentation/members/view/candidates_page.dart'
    as _i1;
import 'package:vote_your_face/presentation/members/view/members_page.dart'
    as _i6;
import 'package:vote_your_face/presentation/members/view/voters_page.dart'
    as _i12;
import 'package:vote_your_face/presentation/ranking/view/ranking_page.dart'
    as _i7;
import 'package:vote_your_face/presentation/rankings/view/rankings_page.dart'
    as _i8;
import 'package:vote_your_face/presentation/routes/router.dart' as _i4;
import 'package:vote_your_face/presentation/settings/view/settings_page.dart'
    as _i9;
import 'package:vote_your_face/presentation/settings/view/user_settings_page.dart'
    as _i11;
import 'package:vote_your_face/presentation/splash/view/splash_page.dart'
    as _i10;

abstract class $AppRouter extends _i13.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    CandidatesRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.CandidatesPage(),
      );
    },
    CircleRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CircleRouteArgs>(
          orElse: () =>
              CircleRouteArgs(circleId: pathParams.getInt('circleId')));
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.CirclePage(
          key: args.key,
          circleId: args.circleId,
        ),
      );
    },
    CirclesRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.CirclesPage(),
      );
    },
    CirclesTabRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.CirclesTabPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.HomePage(),
      );
    },
    MembersRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MembersRouteArgs>(
          orElse: () =>
              MembersRouteArgs(circleId: pathParams.getInt('circleId')));
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.MembersPage(
          key: args.key,
          circleId: args.circleId,
        ),
      );
    },
    RankingRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RankingRouteArgs>(
          orElse: () =>
              RankingRouteArgs(circleId: pathParams.getInt('circleId')));
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.RankingPage(
          key: args.key,
          circleId: args.circleId,
        ),
      );
    },
    RankingsRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.RankingsPage(),
      );
    },
    RankingsTabRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.RankingsTabPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.SettingsPage(),
      );
    },
    SettingsTabRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SettingsTabPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.SplashPage(),
      );
    },
    UserSettingsRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.UserSettingsPage(),
      );
    },
    VotersRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.VotersPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.CandidatesPage]
class CandidatesRoute extends _i13.PageRouteInfo<void> {
  const CandidatesRoute({List<_i13.PageRouteInfo>? children})
      : super(
          CandidatesRoute.name,
          initialChildren: children,
        );

  static const String name = 'CandidatesRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i2.CirclePage]
class CircleRoute extends _i13.PageRouteInfo<CircleRouteArgs> {
  CircleRoute({
    _i14.Key? key,
    required int circleId,
    List<_i13.PageRouteInfo>? children,
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

  static const _i13.PageInfo<CircleRouteArgs> page =
      _i13.PageInfo<CircleRouteArgs>(name);
}

class CircleRouteArgs {
  const CircleRouteArgs({
    this.key,
    required this.circleId,
  });

  final _i14.Key? key;

  final int circleId;

  @override
  String toString() {
    return 'CircleRouteArgs{key: $key, circleId: $circleId}';
  }
}

/// generated route for
/// [_i3.CirclesPage]
class CirclesRoute extends _i13.PageRouteInfo<void> {
  const CirclesRoute({List<_i13.PageRouteInfo>? children})
      : super(
          CirclesRoute.name,
          initialChildren: children,
        );

  static const String name = 'CirclesRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i4.CirclesTabPage]
class CirclesTabRoute extends _i13.PageRouteInfo<void> {
  const CirclesTabRoute({List<_i13.PageRouteInfo>? children})
      : super(
          CirclesTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'CirclesTabRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i5.HomePage]
class HomeRoute extends _i13.PageRouteInfo<void> {
  const HomeRoute({List<_i13.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i6.MembersPage]
class MembersRoute extends _i13.PageRouteInfo<MembersRouteArgs> {
  MembersRoute({
    _i14.Key? key,
    required int circleId,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          MembersRoute.name,
          args: MembersRouteArgs(
            key: key,
            circleId: circleId,
          ),
          rawPathParams: {'circleId': circleId},
          initialChildren: children,
        );

  static const String name = 'MembersRoute';

  static const _i13.PageInfo<MembersRouteArgs> page =
      _i13.PageInfo<MembersRouteArgs>(name);
}

class MembersRouteArgs {
  const MembersRouteArgs({
    this.key,
    required this.circleId,
  });

  final _i14.Key? key;

  final int circleId;

  @override
  String toString() {
    return 'MembersRouteArgs{key: $key, circleId: $circleId}';
  }
}

/// generated route for
/// [_i7.RankingPage]
class RankingRoute extends _i13.PageRouteInfo<RankingRouteArgs> {
  RankingRoute({
    _i14.Key? key,
    required int circleId,
    List<_i13.PageRouteInfo>? children,
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

  static const _i13.PageInfo<RankingRouteArgs> page =
      _i13.PageInfo<RankingRouteArgs>(name);
}

class RankingRouteArgs {
  const RankingRouteArgs({
    this.key,
    required this.circleId,
  });

  final _i14.Key? key;

  final int circleId;

  @override
  String toString() {
    return 'RankingRouteArgs{key: $key, circleId: $circleId}';
  }
}

/// generated route for
/// [_i8.RankingsPage]
class RankingsRoute extends _i13.PageRouteInfo<void> {
  const RankingsRoute({List<_i13.PageRouteInfo>? children})
      : super(
          RankingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'RankingsRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i4.RankingsTabPage]
class RankingsTabRoute extends _i13.PageRouteInfo<void> {
  const RankingsTabRoute({List<_i13.PageRouteInfo>? children})
      : super(
          RankingsTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'RankingsTabRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i9.SettingsPage]
class SettingsRoute extends _i13.PageRouteInfo<void> {
  const SettingsRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SettingsTabPage]
class SettingsTabRoute extends _i13.PageRouteInfo<void> {
  const SettingsTabRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SettingsTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsTabRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i10.SplashPage]
class SplashRoute extends _i13.PageRouteInfo<void> {
  const SplashRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i11.UserSettingsPage]
class UserSettingsRoute extends _i13.PageRouteInfo<void> {
  const UserSettingsRoute({List<_i13.PageRouteInfo>? children})
      : super(
          UserSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserSettingsRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i12.VotersPage]
class VotersRoute extends _i13.PageRouteInfo<void> {
  const VotersRoute({List<_i13.PageRouteInfo>? children})
      : super(
          VotersRoute.name,
          initialChildren: children,
        );

  static const String name = 'VotersRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}
