import 'package:flutter/material.dart';
import 'package:sys_ltd_movies_flutter/core/routing/app_routes.dart';
import 'package:sys_ltd_movies_flutter/features/presentation/views/movies_view.dart';

abstract class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.movies:
        return MaterialPageRoute(builder: (_) => const MoviesView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
