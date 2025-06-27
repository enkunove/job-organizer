import 'package:auto_route/auto_route.dart';
import 'app_routing.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {

  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, path: '/', initial: true),
    AutoRoute(page: HomeRoute.page, path: '/boards'),
    AutoRoute(page: TasksRoute.page, path: '/tasks',),
    AutoRoute(page: LoginRoute.page, path: '/login',),
    AutoRoute(page: RegistrationRoute.page, path: '/register',),
    AutoRoute(page: BoardDetailRoute.page, path: '/boards/:boardId'),
    AutoRoute(page: BoardCreateRoute.page, path: "/boards/create"),

  ];

  @override
  List<AutoRouteGuard> get guards => [
  ];
}