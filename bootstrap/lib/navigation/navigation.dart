import 'package:go_router/go_router.dart';
import 'package:flutter/widgets.dart';
import 'package:application/application.dart';

class Navigation {
  List<RouteBase> get routes => [
    GoRoute(
      path: '/',
      builder: (context, state) => OnboardingScreen(
        onPressed: () {
          context.push('/dashboard');
        },
      ),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => DashboardScreen(
        onPressed: () {
          context.canPop();
        },
      ),
    ),
  ];

  List<GoRouterRedirect> get guards => [];

  RouterConfig<Object> config() => GoRouter(routes: routes);
}
