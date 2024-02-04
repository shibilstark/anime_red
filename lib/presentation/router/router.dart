// ignore_for_file: constant_identifier_names

import 'package:anime_red/presentation/screens/home_screen/home_screen.dart';
import 'package:anime_red/presentation/screens/landing_screen/landing_screen.dart';
import 'package:anime_red/presentation/screens/search_screen/search_screen.dart';
import 'package:anime_red/presentation/screens/watchlist_history_screen/watchlist_history_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const HOME_SCREEN = "/dashboard";
  static const LANDING_SCREEN = "/landing";
  static const SETTINGS_SCREEN = "/settings";
  static const ANIME_INFO_SCREEN = "/anime_info";
  static const WATCHLIST_SCREEN = "/watch_list";
  static const SEARCH_SCREEN = "/search";
  static const WATCH_HISTORY_SCREEN = "/watch_history";

  static Route? ongeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case LANDING_SCREEN:
        return _animatePage(const LandingScreen());
      case SETTINGS_SCREEN:
        return _animatePage(const Scaffold());
      case HOME_SCREEN:
        return _animatePage(const HomeScreen());
      case SEARCH_SCREEN:
        return _animatePage(const SearchScreen());
      case WATCH_HISTORY_SCREEN:
        return _animatePage(const WatchlistHistoryScreen(
            screenType: HistoryScreenType.history));
      case WATCHLIST_SCREEN:
        return _animatePage(const WatchlistHistoryScreen(
            screenType: HistoryScreenType.watchlist));
      default:
        return null;
    }
  }
}

class AppNavigator {
  static pop(BuildContext context, {bool? value}) async {
    Navigator.pop(context, value);
  }

  static push({
    required BuildContext context,
    required String screenName,
    Map<String, dynamic>? arguments,
  }) async {
    Navigator.pushNamed(context, screenName, arguments: arguments);
  }

  static pushReplacement({
    required BuildContext context,
    required String screenName,
    Map<String, dynamic>? arguments,
  }) async {
    Navigator.pushReplacementNamed(context, screenName, arguments: arguments);
  }

  static pushAndRemoveUntil({
    required BuildContext context,
    required String screenName,
    Map<String, dynamic>? arguments,
  }) async {
    Navigator.pushNamedAndRemoveUntil(context, screenName, (predicate) {
      return false;
    });
  }

  static popAndPush(
      {required BuildContext context, required String screenName}) async {
    Navigator.popAndPushNamed(context, screenName);
  }

  static clearRouteIfFirst(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}

Route _animatePage(Widget screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const curve = Curves.bounceIn;
      const reverseCurve = Curves.bounceOut;

      final curvedAnimation = CurvedAnimation(
          parent: animation, curve: curve, reverseCurve: reverseCurve);

      return FadeTransition(
        opacity: curvedAnimation,
        child: child,
      );
    },
  );
}
