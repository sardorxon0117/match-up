import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchup/features/auth/presentation/splash_page.dart';
import 'package:matchup/features/home/presentation/pages/get_all_games_date.dart';
import 'package:matchup/features/league/presentation/pages/search_league.dart';
import 'package:matchup/features/main/main_shell.dart';
import '../../features/players/presentation/pages/search_player.dart';

class AppRouter {
  static const String splash = '/';
  static const String home = '/home';
  static const String games = '/home';
  static const String search_league = '/search_league';
  static const String search_player = '/search_player';

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(path: splash, builder: (_, _) => SplashPage()),
      GoRoute(path: home, builder: (_, _) => MainShell()),
      GoRoute(path: games, builder: (_, _) => GetAllGamesDate()),
      GoRoute(
        path: search_league,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: SearchLeague(),
            transitionDuration: const Duration(milliseconds: 100),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeIn,
                    ),
                    child: child,
                  );
                },
          );
        },
      ),
      GoRoute(
        path: search_player,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: SearchPlayerPage(),
            transitionDuration: const Duration(milliseconds: 100),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeIn,
                ),
                child: child,
              );
            },
          );
        },
      ),
    ],
  );
}
