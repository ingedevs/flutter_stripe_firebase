import 'package:fl_stripe/presentation/pages/home_page.dart';
import 'package:fl_stripe/presentation/pages/success_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      path: HomePage.routePath,
      builder: (_, __) => const HomePage(),
    ),
    GoRoute(
      path: SuccessPage.routePath,
      builder: (_, __) => const SuccessPage(),
    ),
  ],
);
