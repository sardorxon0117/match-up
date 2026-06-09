import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchup/features/home/presentation/bloc/league_games/league_games_bloc.dart';
import 'package:matchup/features/home/presentation/pages/get_all_games_today.dart';
import 'package:matchup/features/league/presentation/widgets/alert.dart';

import '../../../../core/app_constants/app_theme.dart';

class LeagueGamesPage extends StatefulWidget {
  int leagueId;
  int season;

  LeagueGamesPage({super.key, required this.leagueId, required this.season});

  @override
  State<LeagueGamesPage> createState() => _LeagueGamesPageState();
}

class _LeagueGamesPageState extends State<LeagueGamesPage> {
  @override
  void initState() {
    super.initState();
    context.read<LeagueGamesBloc>().add(
      LeagueGamesRequested(leagueId: widget.leagueId, season: widget.season),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeagueGamesBloc, LeagueGamesState>(
      builder: (context, state) {
        if (state is LeagueGamesInitial || state is LeagueGamesLoading) {
          return RefreshIndicator.adaptive(
            onRefresh: () async {
              context.read<LeagueGamesBloc>().add(
                LeagueGamesRequested(leagueId: widget.leagueId, season: widget.season),
              );
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: const [
                SizedBox(height: 300),
                Center(child: CircularProgressIndicator(strokeWidth: 5)),
              ],
            ),
          );
        }

        if (state is LeagueGamesError) {
          return AlertErr(
            title: state.message,
            button1: "Refresh",
            but1_bg: AppTheme.primaryGreen,
            but1_cal: () {
              context.read<LeagueGamesBloc>().add(
                LeagueGamesRequested(leagueId: widget.leagueId, season: widget.season),
              );
            },
          );
        }

        if (state is LeagueGamesLoaded) {
          return RefreshIndicator.adaptive(
            onRefresh: () async {
              context.read<LeagueGamesBloc>().add(
                LeagueGamesRequested(leagueId: widget.leagueId, season: widget.season),
              );
            },
            child: ListView.builder(
              itemCount: state.allGames.response!.length,
              itemBuilder: (context, index) {
                final game = state.allGames.response![index];
                return GameTile(game: game);
              },
            ),
          );
        }

        return Center(
          child: AlertErr(
            title: "Bloc State error!",
            button1: "Refresh",
            but1_cal: () {
              context.read<LeagueGamesBloc>().add(
                LeagueGamesRequested(
                  leagueId: widget.leagueId,
                  season: widget.season,
                ),
              );
            },
            but1_bg: AppTheme.success,
          ),
        );
      },
    );
  }
}
