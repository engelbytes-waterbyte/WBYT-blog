import 'package:flutter/material.dart';
import 'package:website/pages/home.dart';
import 'package:website/pages/blog.dart';
import 'package:website/pages/not_found.dart';

class Route {
  const Route(this.pattern, this.builder);

  final String pattern;
  final WidgetBuilder builder;
}

class WaterbyteApp extends StatelessWidget {
  const WaterbyteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Route?> routes = [
      Route(
        '/',
        (context) => const Home(),
      ),
      Route(
        '/blog',
        (context) => const Blog(),
      ),
    ];
    return MaterialApp(
      theme: ThemeData(fontFamily: "Inter"),
      onGenerateRoute: (RouteSettings settings) {
        Route? foundRoute = routes.firstWhere(
          (route) {
            final regExpPattern = RegExp(r'^' + route!.pattern + r'$');
            return regExpPattern.hasMatch(settings.name ?? "");
          },
          orElse: () => null,
        );
        if (foundRoute == null) return null;
        Widget Function(BuildContext) builder = foundRoute.builder;
        return MaterialPageRoute<void>(
          builder: builder,
          settings: settings,
        );
      },
      onUnknownRoute: (RouteSettings settings) => MaterialPageRoute(
        builder: (context) => const NotFound(),
      ),
    );
  }
}
