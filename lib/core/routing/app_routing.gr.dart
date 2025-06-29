// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:test_task/feature/presentation/view/screens/archive_tasks_screen.dart'
    as _i1;
import 'package:test_task/feature/presentation/view/screens/auth/login_screen.dart'
    as _i5;
import 'package:test_task/feature/presentation/view/screens/auth/registration_screen.dart'
    as _i6;
import 'package:test_task/feature/presentation/view/screens/auth/splash_screen.dart'
    as _i8;
import 'package:test_task/feature/presentation/view/screens/board_create_screen.dart'
    as _i2;
import 'package:test_task/feature/presentation/view/screens/board_detail_screen.dart'
    as _i3;
import 'package:test_task/feature/presentation/view/screens/home_screen.dart'
    as _i4;
import 'package:test_task/feature/presentation/view/screens/settings_screen.dart'
    as _i7;
import 'package:test_task/feature/presentation/view/screens/tasks_screen.dart'
    as _i9;

/// generated route for
/// [_i1.ArchiveTasksScreen]
class ArchiveTasksRoute extends _i10.PageRouteInfo<void> {
  const ArchiveTasksRoute({List<_i10.PageRouteInfo>? children})
    : super(ArchiveTasksRoute.name, initialChildren: children);

  static const String name = 'ArchiveTasksRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i1.ArchiveTasksScreen();
    },
  );
}

/// generated route for
/// [_i2.BoardCreateScreen]
class BoardCreateRoute extends _i10.PageRouteInfo<void> {
  const BoardCreateRoute({List<_i10.PageRouteInfo>? children})
    : super(BoardCreateRoute.name, initialChildren: children);

  static const String name = 'BoardCreateRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i2.BoardCreateScreen();
    },
  );
}

/// generated route for
/// [_i3.BoardDetailScreen]
class BoardDetailRoute extends _i10.PageRouteInfo<void> {
  const BoardDetailRoute({List<_i10.PageRouteInfo>? children})
    : super(BoardDetailRoute.name, initialChildren: children);

  static const String name = 'BoardDetailRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i3.BoardDetailScreen();
    },
  );
}

/// generated route for
/// [_i4.HomeScreen]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute({List<_i10.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomeScreen();
    },
  );
}

/// generated route for
/// [_i5.LoginScreen]
class LoginRoute extends _i10.PageRouteInfo<void> {
  const LoginRoute({List<_i10.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i5.LoginScreen();
    },
  );
}

/// generated route for
/// [_i6.RegistrationScreen]
class RegistrationRoute extends _i10.PageRouteInfo<void> {
  const RegistrationRoute({List<_i10.PageRouteInfo>? children})
    : super(RegistrationRoute.name, initialChildren: children);

  static const String name = 'RegistrationRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i6.RegistrationScreen();
    },
  );
}

/// generated route for
/// [_i7.SettingsScreen]
class SettingsRoute extends _i10.PageRouteInfo<void> {
  const SettingsRoute({List<_i10.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i7.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i8.SplashScreen]
class SplashRoute extends _i10.PageRouteInfo<void> {
  const SplashRoute({List<_i10.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i8.SplashScreen();
    },
  );
}

/// generated route for
/// [_i9.TasksScreen]
class TasksRoute extends _i10.PageRouteInfo<TasksRouteArgs> {
  TasksRoute({
    _i11.Key? key,
    required String boardId,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         TasksRoute.name,
         args: TasksRouteArgs(key: key, boardId: boardId),
         rawPathParams: {'boardId': boardId},
         initialChildren: children,
       );

  static const String name = 'TasksRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TasksRouteArgs>(
        orElse: () => TasksRouteArgs(boardId: pathParams.getString('boardId')),
      );
      return _i9.TasksScreen(key: args.key, boardId: args.boardId);
    },
  );
}

class TasksRouteArgs {
  const TasksRouteArgs({this.key, required this.boardId});

  final _i11.Key? key;

  final String boardId;

  @override
  String toString() {
    return 'TasksRouteArgs{key: $key, boardId: $boardId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TasksRouteArgs) return false;
    return key == other.key && boardId == other.boardId;
  }

  @override
  int get hashCode => key.hashCode ^ boardId.hashCode;
}
