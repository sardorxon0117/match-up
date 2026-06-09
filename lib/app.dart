import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:matchup/core/router/app_router.dart';
import 'package:matchup/features/home/presentation/bloc/date_games/date_games_bloc.dart';
import 'package:matchup/features/home/presentation/bloc/league_games/league_games_bloc.dart';
import 'package:matchup/features/home/presentation/bloc/one_game/one_game_bloc.dart';
import 'package:matchup/features/league/presentation/bloc/all_leagues/all_leagues_bloc.dart';
import 'package:matchup/features/league/presentation/bloc/one_league/one_league_bloc.dart';
import 'package:matchup/features/players/presentation/bloc/all_players/all_players_bloc.dart';
import 'package:matchup/features/players/presentation/bloc/player_teams/player_teams_bloc.dart';
import 'package:matchup/features/players/presentation/bloc/single_player/single_player_bloc.dart';
import 'package:matchup/features/standing/presentation/bloc/standing/standing_bloc.dart';
import 'package:matchup/features/team/presentation/bloc/team_profile/team_profile_bloc.dart';

import 'core/app_constants/app_theme.dart';
import 'core/di/injection.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DateGamesBloc>(create: (_) => getIt<DateGamesBloc>()),
        BlocProvider<OneGameBloc>(create: (_) => getIt<OneGameBloc>()),
        BlocProvider<LeagueGamesBloc>(create: (_) => getIt<LeagueGamesBloc>()),
        BlocProvider<AllLeaguesBloc>(create: (_) => getIt<AllLeaguesBloc>()),
        BlocProvider<OneLeagueBloc>(create: (_) => getIt<OneLeagueBloc>()),
        BlocProvider<StandingBloc>(create: (_) => getIt<StandingBloc>()),
        BlocProvider<AllPlayersBloc>(create: (_) => getIt<AllPlayersBloc>()),
        BlocProvider<SinglePlayerBloc>(create: (_) => getIt<SinglePlayerBloc>()),
        BlocProvider<PlayerTeamsBloc>(create: (_) => getIt<PlayerTeamsBloc>()),
        BlocProvider<TeamProfileBloc>(create: (_) => getIt<TeamProfileBloc>()),
      ],
      child: MaterialApp.router(
        title: 'matchUP',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.dark,
        routerConfig: AppRouter.router,
      ),
    );
  }
}