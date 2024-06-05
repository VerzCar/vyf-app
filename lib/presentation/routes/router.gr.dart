// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;
import 'package:vote_your_face/presentation/circle/view/circle_edit_page.dart'
    as _i2;
import 'package:vote_your_face/presentation/circle/view/circle_page.dart'
    as _i3;
import 'package:vote_your_face/presentation/circles/view/circles_page.dart'
    as _i4;
import 'package:vote_your_face/presentation/home/view/home_page.dart' as _i6;
import 'package:vote_your_face/presentation/members/view/candidates_page.dart'
    as _i1;
import 'package:vote_your_face/presentation/members/view/members_page.dart'
    as _i7;
import 'package:vote_your_face/presentation/members/view/voters_page.dart'
    as _i14;
import 'package:vote_your_face/presentation/ranking/view/ranking_page.dart'
    as _i8;
import 'package:vote_your_face/presentation/rankings/view/rankings_page.dart'
    as _i9;
import 'package:vote_your_face/presentation/routes/router.dart' as _i5;
import 'package:vote_your_face/presentation/settings/view/settings_page.dart'
    as _i10;
import 'package:vote_your_face/presentation/settings/view/user_edit_settings_page.dart'
    as _i12;
import 'package:vote_your_face/presentation/settings/view/user_settings_page.dart'
    as _i13;
import 'package:vote_your_face/presentation/splash/view/splash_page.dart'
    as _i11;

abstract class $AppRouter extends _i15.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i15.PageFactory> pagesMap = {
    CandidatesRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.CandidatesPage(),
      );
    },
    CircleEditRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CircleEditRouteArgs>(
          orElse: () =>
              CircleEditRouteArgs(circleId: pathParams.getInt('circleId')));
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.CircleEditPage(
          key: args.key,
          circleId: args.circleId,
        ),
      );
    },
    CircleRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CircleRouteArgs>(
          orElse: () =>
              CircleRouteArgs(circleId: pathParams.getInt('circleId')));
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.CirclePage(
          key: args.key,
          circleId: args.circleId,
        ),
      );
    },
    CirclesRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.CirclesPage(),
      );
    },
    CirclesTabRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.CirclesTabPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.HomePage(),
      );
    },
    MembersCandidatesTabRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.MembersCandidatesTabPage(),
      );
    },
    MembersRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MembersRouteArgs>(
          orElse: () =>
              MembersRouteArgs(circleId: pathParams.getInt('circleId')));
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.MembersPage(
          key: args.key,
          circleId: args.circleId,
        ),
      );
    },
    MembersVotersTabRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.MembersVotersTabPage(),
      );
    },
    RankingRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RankingRouteArgs>(
          orElse: () =>
              RankingRouteArgs(circleId: pathParams.getInt('circleId')));
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.RankingPage(
          key: args.key,
          circleId: args.circleId,
        ),
      );
    },
    RankingsRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.RankingsPage(),
      );
    },
    RankingsTabRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.RankingsTabPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.SettingsPage(),
      );
    },
    SettingsTabRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.SettingsTabPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.SplashPage(),
      );
    },
    UserEditSettingsRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.UserEditSettingsPage(),
      );
    },
    UserSettingsRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.UserSettingsPage(),
      );
    },
    VotersRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.VotersPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.CandidatesPage]
class CandidatesRoute extends _i15.PageRouteInfo<void> {
  const CandidatesRoute({List<_i15.PageRouteInfo>? children})
      : super(
          CandidatesRoute.name,
          initialChildren: children,
        );

  static const String name = 'CandidatesRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i2.CircleEditPage]
class CircleEditRoute extends _i15.PageRouteInfo<CircleEditRouteArgs> {
  CircleEditRoute({
    _i16.Key? key,
    required int circleId,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          CircleEditRoute.name,
          args: CircleEditRouteArgs(
            key: key,
            circleId: circleId,
          ),
          rawPathParams: {'circleId': circleId},
          initialChildren: children,
        );

  static const String name = 'CircleEditRoute';

  static const _i15.PageInfo<CircleEditRouteArgs> page =
      _i15.PageInfo<CircleEditRouteArgs>(name);
}

class CircleEditRouteArgs {
  const CircleEditRouteArgs({
    this.key,
    required this.circleId,
  });

  final _i16.Key? key;

  final int circleId;

  @override
  String toString() {
    return 'CircleEditRouteArgs{key: $key, circleId: $circleId}';
  }
}

/// generated route for
/// [_i3.CirclePage]
class CircleRoute extends _i15.PageRouteInfo<CircleRouteArgs> {
  CircleRoute({
    _i16.Key? key,
    required int circleId,
    List<_i15.PageRouteInfo>? children,
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

  static const _i15.PageInfo<CircleRouteArgs> page =
      _i15.PageInfo<CircleRouteArgs>(name);
}

class CircleRouteArgs {
  const CircleRouteArgs({
    this.key,
    required this.circleId,
  });

  final _i16.Key? key;

  final int circleId;

  @override
  String toString() {
    return 'CircleRouteArgs{key: $key, circleId: $circleId}';
  }
}

/// generated route for
/// [_i4.CirclesPage]
class CirclesRoute extends _i15.PageRouteInfo<void> {
  const CirclesRoute({List<_i15.PageRouteInfo>? children})
      : super(
          CirclesRoute.name,
          initialChildren: children,
        );

  static const String name = 'CirclesRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i5.CirclesTabPage]
class CirclesTabRoute extends _i15.PageRouteInfo<void> {
  const CirclesTabRoute({List<_i15.PageRouteInfo>? children})
      : super(
          CirclesTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'CirclesTabRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i6.HomePage]
class HomeRoute extends _i15.PageRouteInfo<void> {
  const HomeRoute({List<_i15.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i5.MembersCandidatesTabPage]
class MembersCandidatesTabRoute extends _i15.PageRouteInfo<void> {
  const MembersCandidatesTabRoute({List<_i15.PageRouteInfo>? children})
      : super(
          MembersCandidatesTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'MembersCandidatesTabRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i7.MembersPage]
class MembersRoute extends _i15.PageRouteInfo<MembersRouteArgs> {
  MembersRoute({
    _i16.Key? key,
    required int circleId,
    List<_i15.PageRouteInfo>? children,
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

  static const _i15.PageInfo<MembersRouteArgs> page =
      _i15.PageInfo<MembersRouteArgs>(name);
}

class MembersRouteArgs {
  const MembersRouteArgs({
    this.key,
    required this.circleId,
  });

  final _i16.Key? key;

  final int circleId;

  @override
  String toString() {
    return 'MembersRouteArgs{key: $key, circleId: $circleId}';
  }
}

/// generated route for
/// [_i5.MembersVotersTabPage]
class MembersVotersTabRoute extends _i15.PageRouteInfo<void> {
  const MembersVotersTabRoute({List<_i15.PageRouteInfo>? children})
      : super(
          MembersVotersTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'MembersVotersTabRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i8.RankingPage]
class RankingRoute extends _i15.PageRouteInfo<RankingRouteArgs> {
  RankingRoute({
    _i16.Key? key,
    required int circleId,
    List<_i15.PageRouteInfo>? children,
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

  static const _i15.PageInfo<RankingRouteArgs> page =
      _i15.PageInfo<RankingRouteArgs>(name);
}

class RankingRouteArgs {
  const RankingRouteArgs({
    this.key,
    required this.circleId,
  });

  final _i16.Key? key;

  final int circleId;

  @override
  String toString() {
    return 'RankingRouteArgs{key: $key, circleId: $circleId}';
  }
}

/// generated route for
/// [_i9.RankingsPage]
class RankingsRoute extends _i15.PageRouteInfo<void> {
  const RankingsRoute({List<_i15.PageRouteInfo>? children})
      : super(
          RankingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'RankingsRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i5.RankingsTabPage]
class RankingsTabRoute extends _i15.PageRouteInfo<void> {
  const RankingsTabRoute({List<_i15.PageRouteInfo>? children})
      : super(
          RankingsTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'RankingsTabRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i10.SettingsPage]
class SettingsRoute extends _i15.PageRouteInfo<void> {
  const SettingsRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i5.SettingsTabPage]
class SettingsTabRoute extends _i15.PageRouteInfo<void> {
  const SettingsTabRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SettingsTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsTabRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i11.SplashPage]
class SplashRoute extends _i15.PageRouteInfo<void> {
  const SplashRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i12.UserEditSettingsPage]
class UserEditSettingsRoute extends _i15.PageRouteInfo<void> {
  const UserEditSettingsRoute({List<_i15.PageRouteInfo>? children})
      : super(
          UserEditSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserEditSettingsRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i13.UserSettingsPage]
class UserSettingsRoute extends _i15.PageRouteInfo<void> {
  const UserSettingsRoute({List<_i15.PageRouteInfo>? children})
      : super(
          UserSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserSettingsRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i14.VotersPage]
class VotersRoute extends _i15.PageRouteInfo<void> {
  const VotersRoute({List<_i15.PageRouteInfo>? children})
      : super(
          VotersRoute.name,
          initialChildren: children,
        );

  static const String name = 'VotersRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}
