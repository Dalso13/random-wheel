import 'package:go_router/go_router.dart';

import 'dart:convert';
import 'package:go_router/go_router.dart';
import 'package:random_wheel/random_wheel_main.dart';
import 'package:random_wheel/random_wheel.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const RandomWheelMain(),
    ),
    GoRoute(
      path: '/wheel',
      builder: (context, state) {
        return RandomWheel(items: state.uri.queryParameters['items']!.split(','),);
      },
    ),
  ],
);