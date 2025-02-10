import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_application_manager_new/pages/home_page.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return HomePage();
      },
    ),
  ],
);
