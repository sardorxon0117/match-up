import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:matchup/core/app_constants/app_theme.dart';
import 'package:matchup/core/app_constants/image_const.dart';
import 'package:matchup/core/router/app_router.dart';
import 'package:matchup/features/home/domain/entities/game.dart';
import 'package:matchup/features/home/presentation/bloc/date_games/date_games_bloc.dart';
import 'package:matchup/features/home/presentation/pages/get_one_game.dart';
import 'package:matchup/features/home/presentation/widgets/divader.dart';
import 'package:matchup/features/league/presentation/pages/league_page.dart';
import 'package:matchup/features/league/presentation/widgets/alert.dart';

class GetAllGamesToday extends StatefulWidget {
  const GetAllGamesToday({super.key});

  @override
  State<GetAllGamesToday> createState() => _GetAllGamesTodayState();
}

class _GetAllGamesTodayState extends State<GetAllGamesToday> {
  late final String todayDate;
  late final int timeZone;

  @override
  void initState() {
    super.initState();

    todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    context.read<DateGamesBloc>().add(DateGamesRequested(date: "2026-06-03"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Image.asset(ImageConst.logo),
        ),
        title: GestureDetector(
          onTap: () {
            context.push(AppRouter.search_league);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            height: 45,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: AppTheme.surfaceDark,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                    Icons.search_rounded,
                    color: AppTheme.textMutedDark,
                  ),
                ),
                SizedBox(width: 8),
                Text("Search leagues", style: AppTheme.grayMedium),
              ],
            ),
          ),
        ),
        centerTitle: false,
      ),
      body: BlocBuilder<DateGamesBloc, DateGamesState>(
        builder: (context, state) {
          if (state is DateGamesInitial || state is DateGamesLoading) {
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                context.read<DateGamesBloc>().add(
                  DateGamesRequested(date: todayDate),
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

          if (state is DateGamesError) {
            return AlertErr(
              title: state.message,
              button1: "Refresh",
              but1_bg: AppTheme.primaryGreen,
              but1_cal: () {
                context.read<DateGamesBloc>().add(
                  DateGamesRequested(date: todayDate),
                );
              },
            );
          }

          // LOADED
          if (state is DateGamesLoaded) {
            final games = state.allGames.response ?? [];

            if (games.isEmpty) {
              return AlertErr(title: "There are no games on this date!");
            }

            final Map<int, List<OneResponse>> groupedGames = {};

            for (final game in games) {
              final leagueId = game.league.id ?? 0;

              groupedGames.putIfAbsent(leagueId, () => []);
              groupedGames[leagueId]!.add(game);
            }

            final leagueIds = groupedGames.keys.toList()
              ..sort((a, b) => a.compareTo(b));

            return RefreshIndicator.adaptive(
              onRefresh: () async {
                context.read<DateGamesBloc>().add(
                  DateGamesRequested(date: "2026-06-03"),
                );
              },
              child: ListView.separated(
                padding: const EdgeInsets.only(
                  top: 12,
                  left: 12,
                  right: 12,
                  bottom: 120,
                ),
                itemCount: leagueIds.length,

                itemBuilder: (context, index) {
                  final leagueId = leagueIds[index];
                  final leagueGames = groupedGames[leagueId]!;

                  final league = leagueGames.first.league;

                  return Container(
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceDark,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LeaguePage(
                                  id: league.id ?? 0,
                                  season: league.season!,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppTheme.surfaceDark,
                            ),
                            child: Row(
                              children: [
                                Image.network(
                                  league.logo ?? "",
                                  width: 32,
                                  height: 32,
                                  errorBuilder: (_, __, ___) =>
                                      const Icon(Icons.sports_soccer),
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        league.name ?? "Unknown League",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),

                                      const SizedBox(height: 2),

                                      Text(
                                        league.country ?? "",
                                        style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        ...leagueGames.map((game) {
                          return GameTile(game: game);
                        }),
                      ],
                    ),
                  );
                },

                separatorBuilder: (context, index) => const SizedBox(height: 8),
              ),
            );
          }

          return AlertErr(title: "Unknown situation");
        },
      ),
    );
  }
}

class GameTile extends StatelessWidget {
  final OneResponse game;

  const GameTile({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.parse(game.fixture.date.toString()).toLocal();

    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GetOneGame(id: game.fixture.id!),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(0),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppTheme.primaryGreen,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      ),
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Row(
          children: [
            // Time an Status
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${dateTime.day}/${dateTime.month}/${dateTime.year}",
                  style: AppTheme.tileScore,
                ),
                SizedBox(height: 8),
                Text(
                  game.fixture.status.short == "NS"
                      ? "${dateTime.hour.toString().length < 2 ? "0${dateTime.hour}" : dateTime.hour} : ${dateTime.minute.toString().length < 2 ? dateTime.minute.toString() + "0" : dateTime.minute.toString()}"
                      : game.fixture.status.short!,
                  style: AppTheme.tileScore,
                ),
              ],
            ),
            VerticalDivader2(color: AppTheme.textMutedDark, margin: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  game.teams.home.logo!,
                  height: 20,
                  width: 20,
                  errorBuilder: (context, build, stackTrace) {
                    return Icon(Icons.sports_soccer_sharp);
                  },
                ),
                SizedBox(height: 5),
                Image.network(
                  game.teams.away.logo!,
                  height: 20,
                  width: 20,
                  errorBuilder: (context, build, stackTrace) {
                    return Icon(Icons.sports_soccer_sharp);
                  },
                ),
              ],
            ),
            SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game.teams.home.name!,
                    style: game.teams.home.winner == true
                        ? AppTheme.tileTeamWin
                        : AppTheme.tileTeam,
                  ),
                  SizedBox(height: 12),
                  Text(
                    game.teams.away.name!,
                    style: game.teams.away.winner == true
                        ? AppTheme.tileTeamWin
                        : AppTheme.tileTeam,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  game.goals.home == null ? "" : game.goals.home.toString(),
                  style: game.teams.home.winner == true
                      ? AppTheme.tileTeamWin
                      : AppTheme.tileTeam,
                ),
                SizedBox(height: 12),
                Text(
                  game.goals.away == null ? "" : game.goals.away.toString(),
                  style: game.teams.away.winner == true
                      ? AppTheme.tileTeamWin
                      : AppTheme.tileTeam,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
