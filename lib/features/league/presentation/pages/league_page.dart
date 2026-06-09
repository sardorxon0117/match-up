import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchup/core/app_constants/app_theme.dart';
import 'package:matchup/features/home/presentation/bloc/league_games/league_games_bloc.dart';
import 'package:matchup/features/league/presentation/bloc/one_league/one_league_bloc.dart';
import 'package:matchup/features/league/presentation/pages/league_games_page.dart';
import 'package:matchup/features/standing/presentation/bloc/standing/standing_bloc.dart';
import 'package:matchup/features/standing/presentation/pages/standing_page.dart';

import '../widgets/alert.dart';

class LeaguePage extends StatefulWidget {
  int id;
  int season;

  LeaguePage({super.key, required this.id, required this.season});

  @override
  State<LeaguePage> createState() => _LeaguePageState();
}

class _LeaguePageState extends State<LeaguePage> {
  @override
  void initState() {
    super.initState();
    context.read<OneLeagueBloc>().add(OneLeagueRequested(id: widget.id));
    context.read<StandingBloc>().add(
      StandingRequested(leagueId: widget.id, season: widget.season),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.surfaceDark,
        forceMaterialTransparency: false,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_rounded, size: 28),
        ),
      ),
      body: BlocBuilder<OneLeagueBloc, OneLeagueState>(
        builder: (context, state) {
          if (state is OneLeagueInitial || state is OneLeagueLoading) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 5,
                strokeCap: StrokeCap.round,
              ),
            );
          }

          if (state is OneLeagueError) {
            return AlertErr(
              title: state.message,
              button1: "Refresh",
              but1_bg: AppTheme.primaryGreen,
              but1_cal: () {
                context.read<OneLeagueBloc>().add(OneLeagueRequested(id: widget.id));
                context.read<StandingBloc>().add(
                  StandingRequested(leagueId: widget.id, season: widget.season),
                );
              },
            );
          }

          if (state is OneLeagueLoaded) {
            final league = state.leaguee.response[0];

            List<Widget> _tabs = [
              if (league.seasons.last.coverage.standings)
                SizedBox(height: 40, child: Center(child: Text("Standing"))),
              SizedBox(height: 40, child: Center(child: Text("Games"))),
            ];
            return DefaultTabController(
              length: _tabs.length,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 12,
                    ),
                    color: AppTheme.surfaceDark,
                    width: double.infinity,
                    height: 130,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: AppTheme.dividerLight,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        league.league.logo,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                              
                                  const SizedBox(width: 8),
                              
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          league.league.name,
                                          style: AppTheme.heading2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          league.country.name,
                                          style: AppTheme.bodyLarge,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            GestureDetector(
                              onTap: () async {
                                int? selectedYear = await showYearSelectBar(
                                  context,
                                  widget.season,
                                  league.seasons,
                                );

                                if (selectedYear != null) {
                                  setState(() {
                                    widget.season = selectedYear;
                                  });

                                  context.read<StandingBloc>().add(
                                    StandingRequested(
                                      leagueId: widget.id,
                                      season: selectedYear,
                                    ),
                                  );

                                  context.read<LeagueGamesBloc>().add(
                                    LeagueGamesRequested(
                                      leagueId: widget.id,
                                      season: selectedYear,
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.dividerDark,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      widget.season.toString(),
                                      style: const TextStyle(
                                        color: AppTheme.textPrimaryDark,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Icon(Icons.keyboard_arrow_down_rounded),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: TabBar(
                            isScrollable: false,
                            dividerColor: Colors.transparent,
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabs: _tabs,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: TabBarView(
                      children: [
                        if (league.seasons.last.coverage.standings) StandingPage(
                          leagueId: widget.id,
                          season: widget.season,
                        ),
                        LeagueGamesPage(
                          leagueId: widget.id,
                          season: widget.season,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return Center(
            child: AlertErr(
              title: "Bloc State error!",
              button1: "Refresh",
              but1_cal: () {
                context.read<OneLeagueBloc>().add(
                  OneLeagueRequested(id: widget.id),
                );
              },
              but1_bg: AppTheme.success,
            ),
          );
        },
      ),
    );
  }
}
