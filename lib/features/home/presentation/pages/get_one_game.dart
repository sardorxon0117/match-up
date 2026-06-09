import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:matchup/core/app_constants/app_theme.dart';
import 'package:matchup/core/app_constants/image_const.dart';
import 'package:matchup/features/home/domain/entities/game.dart';
import 'package:matchup/features/home/presentation/bloc/one_game/one_game_bloc.dart';
import 'package:matchup/features/home/presentation/pages/get_game_statistics.dart';
import 'package:matchup/features/home/presentation/pages/match_lineups.dart';
import 'package:matchup/features/league/presentation/pages/league_page.dart';
import 'package:matchup/features/standing/presentation/pages/standing_page.dart';

import '../../../league/presentation/widgets/alert.dart';
import '../../../team/presentation/pages/team_page.dart';

class GetOneGame extends StatefulWidget {
  int id;

  GetOneGame({super.key, required this.id});

  @override
  State<GetOneGame> createState() => _GetOneGameState();
}

class _GetOneGameState extends State<GetOneGame> {
  @override
  void initState() {
    super.initState();
    context.read<OneGameBloc>().add(OneGameRequested(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    OneResponse gamee;
    return Scaffold(
      body: BlocBuilder<OneGameBloc, OneGameState>(
        builder: (context, state) {
          if (state is OneGameLoading || state is OneGameInitial) {
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                context.read<OneGameBloc>().add(OneGameRequested(id: widget.id));
              },
              child: ListView(
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(height: 300),
                  Center(child: CircularProgressIndicator(strokeWidth: 5)),
                ],
              ),
            );
          }

          if (state is OneGameError) {
            return AlertErr(
              title: state.message,
              button1: "Refresh",
              but1_bg: AppTheme.primaryGreen,
              but1_cal: () {
                context.read<OneGameBloc>().add(OneGameRequested(id: widget.id));
              },
            );
          }

          if (state is OneGameLoaded) {
            final game = state.game.response![0];
            List<Widget> _tabs = [
              SizedBox(height: 40, child: Center(child: Text("Details"))),
              if (game.lineups!.length != 0) SizedBox(height: 40, child: Center(child: Text("Lineups"))),
              if (game.league.standings == true) SizedBox(height: 40, child: Center(child: Text("Standing"))),
              SizedBox(height: 40, child: Center(child: Text("Statistics"))),
            ];
            gamee = game;
            final dateTime = DateTime.parse(
              game.fixture.date!.toString(),
            ).toLocal();
            return DefaultTabController(
              length: _tabs.length,
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: 250,
                        child: Stack(
                          children: [
                            Image.asset(
                              ImageConst.defoultstadion,
                              width: double.maxFinite,
                              height: double.maxFinite,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              width: double.maxFinite,
                              height: double.maxFinite,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    AppTheme.backgroundDark.withOpacity(0.8),
                                    AppTheme.backgroundDark,
                                  ],
                                  transform: GradientRotation(1.6),
                                ),
                              ),
                              child: SafeArea(
                                bottom: false,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Center(
                                              child: Icon(
                                                Icons.arrow_back_rounded,
                                                size: 32,
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              "${dateTime.day.toString().length < 2 ? "0${dateTime.day}" : dateTime.day}/${dateTime.month.toString().length < 2 ? "0${dateTime.month}" : dateTime.month}/${dateTime.year} • ${dateTime.hour.toString().length < 2 ? "0${dateTime.hour}" : dateTime.hour} : ${dateTime.minute.toString().length < 2 ? "${dateTime.minute}0" : dateTime.minute}",
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              context.read<OneGameBloc>().add(
                                                OneGameRequested(id: widget.id),
                                              );
                                            },
                                            icon: Center(
                                              child: Icon(
                                                Icons.refresh,
                                                size: 32,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => TeamPage(teamId: game.teams.home.id!)));
                                              },
                                              child: Container(
                                                width: 100,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.network(
                                                      game.teams.home.logo!,
                                                      height: 80,
                                                    ),
                                                    Text(
                                                      game.teams.home.name!,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    game.goals.home == null
                                                        ? "${dateTime.hour.toString().length < 2 ? "0${dateTime.hour}" : dateTime.hour} : ${dateTime.minute.toString().length < 2 ? "${dateTime.minute}0" : dateTime.minute}"
                                                        : "${game.goals.home} : ${game.goals.away}",

                                                    style:
                                                        game.goals.home != null
                                                        ? AppTheme
                                                              .progressNumber
                                                        : AppTheme.heading1,
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    switch ("${game.fixture.status.short}") {
                                                      "PEN" =>
                                                        "Match Finished\nPenalties ${game.score.penalty.home} : ${game.score.penalty.away}",
                                                      "NS" =>
                                                        "${dateTime.day}/${dateTime.month}/${dateTime.year}",
                                                      "1H" || "2H" || "LIVE" =>
                                                        "LIVE: ${game.fixture.status.elapsed}'",
                                                      "ET" =>
                                                        "Extra Time: ${game.fixture.status.elapsed}'",
                                                      "FT" => "Finished",
                                                      "HT" => "Half Time",
                                                      "PST" =>
                                                        "Match Postponed",
                                                      _ =>
                                                        "  ${game.fixture.status.long!}  ",
                                                    },
                                                    textAlign: TextAlign.center,
                                                    overflow: TextOverflow.fade,
                                                    style:
                                                        switch ("${game.fixture.status.short}") {
                                                          "PEN" =>
                                                            AppTheme.caption,
                                                          "NS" =>
                                                            AppTheme.bodyLarge,
                                                          "1H" ||
                                                          "2H" ||
                                                          "LIVE" =>
                                                            AppTheme
                                                                .statusEllepsed,
                                                          "ET" =>
                                                            AppTheme
                                                                .statusEllepsed,
                                                          "FT" =>
                                                            AppTheme.bodyLarge,
                                                          "HT" =>
                                                            AppTheme
                                                                .statusEllepsed,
                                                          "PST" =>
                                                            AppTheme.bodyLarge,
                                                          _ =>
                                                            AppTheme.tileTeam,
                                                        },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => TeamPage(teamId: game.teams.away.id!)));
                                              },
                                              child: Container(
                                                width: 100,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.network(
                                                      game.teams.away.logo!,
                                                      height: 80,
                                                    ),
                                                    Text(
                                                      game.teams.away.name!,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        height: 50,
                        color: AppTheme.backgroundDark,
                        padding: EdgeInsets.zero,
                        child: TabBar(
                          indicatorAnimation: TabIndicatorAnimation.elastic,
                          isScrollable: true,
                          tabAlignment: TabAlignment.center,
                          dividerColor: Colors.transparent,
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelStyle: AppTheme.bodyLarge,
                          padding: EdgeInsets.zero,
                          tabs: _tabs,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      child: TabBarView(
                        children: [
                          MatchDetails(game: game, dateTime: dateTime),
                          if (game.lineups!.length != 0) MatchLineups(game: game),
                          if (game.league.standings == true) StandingPage(leagueId: game.league.id!, season: game.league.season!),
                          GetGameStatistics(game: game)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}


class MatchDetails extends StatelessWidget {
  OneResponse game;
  DateTime dateTime;

  MatchDetails({super.key, required this.game, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(12),
      children: [
        SizedBox(
          height: 50,
          width: double.maxFinite,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              backgroundColor: AppTheme.surfaceElevatedDark,
              elevation: 0,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LeaguePage(id: game.league.id!, season: game.league.season!,)));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(game.league.logo!),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "${game.league.country}, ${game.league.name}, ${game.league.round}",
                    style: AppTheme.tileTeam,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.chevron_right_rounded, size: 24),
              ],
            ),
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.surfaceElevatedDark,
            borderRadius: BorderRadius.circular(12),
          ),
          child: game.events!.isNotEmpty
              ? ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: game.events!.length,
                  itemBuilder: (_, index) {
                    final event = game.events![index];

                    return Container(
                      width: double.maxFinite,
                      child: event.team.id == game.teams.home.id
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 35,
                                  child: Center(
                                    child: Text(
                                      event.time.extra == null
                                          ? "${event.time.elapsed}'"
                                          : "${event.time.elapsed! + event.time.extra!}'",
                                      style: AppTheme.tileTeam,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                if (event.type == "Var")
                                  Icon(Icons.tv, size: 20, color: Colors.white),
                                if (event.type == "Goal")
                                  Icon(Icons.sports_soccer_outlined, size: 20),
                                if (event.type == "subst")
                                  Icon(Icons.repeat_rounded, size: 22),
                                if (event.type == "Card")
                                  if (event.detail == "Yellow Card")
                                    Container(
                                      width: 20,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    )
                                  else if (event.detail == "Red Card")
                                    Container(
                                      width: 20,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                SizedBox(width: 10),
                                Text(
                                  style: AppTheme.tileTeam,
                                  event.assist.name != null
                                      ? event.type == "subst"
                                            ? event.assist.name ?? "Player"
                                            : event.player.name ?? "Player"
                                      : event.player.name ??
                                            event.assist.name ??
                                            "Player",
                                ),
                                SizedBox(width: 10),
                                event.assist.name != null
                                    ? Expanded(
                                        child: Text(
                                          style: AppTheme.tileTeamGrey,
                                          event.type == "subst"
                                              ? event.player.name ?? "Player"
                                              : event.assist.name ?? "Player",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                        ),
                                      )
                                    : SizedBox.shrink(),
                                event.type == "Var"
                                    ? SizedBox(width: 10)
                                    : SizedBox.shrink(),
                                event.type == "Var"
                                    ? Expanded(
                                        child: Text(
                                          style: AppTheme.tileTeamGrey,
                                          event.detail!,
                                        ),
                                      )
                                    : SizedBox.shrink(),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                event.type == "Var"
                                    ? Text(
                                        style: AppTheme.tileTeamGrey,
                                        event.detail!,
                                      )
                                    : SizedBox.shrink(),
                                event.type == "Var"
                                    ? SizedBox(width: 10)
                                    : SizedBox.shrink(),
                                event.assist.name != null
                                    ? Expanded(
                                        child: Text(
                                          style: AppTheme.tileTeamGrey,
                                          event.type == "subst"
                                              ? event.player.name ?? "Player"
                                              : event.assist.name ?? "Player",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.end,
                                        ),
                                      )
                                    : SizedBox.shrink(),
                                SizedBox(width: 10),
                                Text(
                                  style: AppTheme.tileTeam,
                                  event.assist.name != null
                                      ? event.type == "subst"
                                            ? event.assist.name ?? "Player"
                                            : event.player.name ?? "Player"
                                      : event.player.name ??
                                            event.assist.name ??
                                            "Player",
                                ),
                                SizedBox(width: 10),
                                if (event.type == "Var")
                                  Icon(Icons.tv, size: 20, color: Colors.white),
                                if (event.type == "Goal")
                                  Icon(Icons.sports_soccer_outlined, size: 20),
                                if (event.type == "subst")
                                  Icon(Icons.repeat_rounded, size: 22),
                                if (event.type == "Card")
                                  if (event.detail == "Yellow Card")
                                    Container(
                                      width: 20,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    )
                                  else if (event.detail == "Red Card")
                                    Container(
                                      width: 20,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                SizedBox(width: 10),
                                SizedBox(
                                  width: 35,
                                  child: Center(
                                    child: Text(
                                      event.time.extra == null
                                          ? "${event.time.elapsed}'"
                                          : "${event.time.elapsed! + event.time.extra!}'",
                                      style: AppTheme.tileTeam,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: 24),
                )
              : Text("Not Events", style: AppTheme.grayMedium),
        ),
        SizedBox(height: 12),
        Container(
          clipBehavior: Clip.antiAlias,
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: AppTheme.surfaceElevatedDark,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 12),
                width: double.maxFinite,
                child: Row(
                  children: [
                    Icon(Icons.date_range),
                    SizedBox(width: 8),
                    Text(
                      "${dateTime.day.toString().length < 2 ? "0${dateTime.day}" : dateTime.day}/${dateTime.month.toString().length < 2 ? "0${dateTime.month}" : dateTime.month}/${dateTime.year} • ${dateTime.hour.toString().length < 2 ? "0${dateTime.hour}" : dateTime.hour} : ${dateTime.minute.toString().length < 2 ? "${dateTime.minute}0" : dateTime.minute}",
                      style: AppTheme.tileTeam,
                    ),
                  ],
                ),
              ),
              game.fixture.venue.name != null
                  ? Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.stadium_outlined, size: 24),
                          SizedBox(width: 10),
                          if (game.fixture.venue.name != null &&
                              game.fixture.venue.city != null)
                            Expanded(
                              child: Text(
                                "${game.fixture.venue.city}, ${game.fixture.venue.name}",
                                style: AppTheme.tileTeam,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          else if (game.fixture.venue.name != null)
                            Expanded(
                              child: Text(
                                "${game.fixture.venue.name}",
                                style: AppTheme.tileTeam,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          else if (game.fixture.venue.city != null)
                            Expanded(
                              child: Text(
                                "${game.fixture.venue.city}",
                                style: AppTheme.tileTeam,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
              game.fixture.referee != null
                  ? Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      width: double.maxFinite,
                      child: Row(
                        children: [
                          Icon(Icons.sports),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Referee: ${game.fixture.referee}",
                              style: AppTheme.tileTeam,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}
