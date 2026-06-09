import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchup/core/app_constants/app_theme.dart';
import 'package:matchup/features/league/presentation/widgets/alert.dart';
import 'package:matchup/features/standing/domain/entities/standing.dart';
import 'package:matchup/features/standing/presentation/bloc/standing/standing_bloc.dart';

import '../../../team/presentation/pages/team_page.dart';

class StandingPage extends StatefulWidget {
  int leagueId;
  int season;

  StandingPage({super.key, required this.leagueId, required this.season});

  @override
  State<StandingPage> createState() => _StandingPageState();
}

class _StandingPageState extends State<StandingPage> {
  @override
  void initState() {
    super.initState();
    context.read<StandingBloc>().add(
      StandingRequested(leagueId: widget.leagueId, season: widget.season),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StandingBloc, StandingState>(
      builder: (context, state) {
        if (state is StandingInitial || state is StandingLoading) {
          return RefreshIndicator.adaptive(
            onRefresh: () async {
              context.read<StandingBloc>().add(
                StandingRequested(leagueId: widget.leagueId, season: widget.season),
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

        if (state is StandingError) {
          return AlertErr(
            title: state.message
          );
        }

        if (state is StandingLoaded) {
          final responses = state.standing.response;

          if (responses.isEmpty || responses.first.league.standings.isEmpty) {
            return const Center(
              child: Text(
                "Standings Not Found",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final List<Standing> standings = [];

          for (final group in responses.first.league.standings) {
            standings.addAll(group);
          }

          standings.sort((a, b) => a.rank.compareTo(b.rank));

          return Container(
            height: double.maxFinite,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: AppTheme.backgroundDark,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: const BoxDecoration(color: AppTheme.surfaceDark),
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: Text(
                          "#",
                          style: TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Team",
                          style: TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 28,
                        child: Text(
                          "P",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white54),
                        ),
                      ),
                      SizedBox(
                        width: 28,
                        child: Text(
                          "W",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white54),
                        ),
                      ),
                      SizedBox(
                        width: 28,
                        child: Text(
                          "D",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white54),
                        ),
                      ),
                      SizedBox(
                        width: 28,
                        child: Text(
                          "L",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white54),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                        child: Text(
                          "GD",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white54),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                        child: Text(
                          "PTS",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white54),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: RefreshIndicator.adaptive(
                    onRefresh: () async {
                      context.read<StandingBloc>().add(
                        StandingRequested(leagueId: widget.leagueId, season: widget.season),
                      );
                    },
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 14),
                      itemCount: standings.length,
                      itemBuilder: (context, index) {
                        final standing = standings[index];

                        final previous = index > 0 ? standings[index - 1] : null;

                        final bool showDescription =
                            previous == null ||
                            previous.description != standing.description;

                        final zoneColor = getZoneColor(standing.description);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (showDescription &&
                                standing.description != null &&
                                standing.description!.isNotEmpty)
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: zoneColor.withOpacity(.12),
                                  border: Border(
                                    left: BorderSide(color: zoneColor, width: 4),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.emoji_events,
                                      size: 15,
                                      color: zoneColor,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        standing.description!,
                                        style: TextStyle(
                                          color: zoneColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => TeamPage(teamId: standing.team.id)));
                              },
                              child: Container(
                                height: 58,
                                decoration: BoxDecoration(
                                  color: AppTheme.backgroundDark,
                                  border: Border(
                                    left: BorderSide(color: zoneColor, width: 4),
                                    bottom: BorderSide(
                                      color: Colors.white.withOpacity(.05),
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 26,
                                        height: 26,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: zoneColor.withOpacity(.15),
                                        ),
                                        child: Text(
                                          standing.rank.toString(),
                                          style: TextStyle(
                                            color: zoneColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(width: 12),

                                      Expanded(
                                        child: Row(
                                          children: [
                                            Image.network(
                                              standing.team.logo,
                                              width: 24,
                                              height: 24,
                                              errorBuilder: (_, __, ___) =>
                                                  const Icon(
                                                    Icons.shield,
                                                    color: Colors.grey,
                                                    size: 20,
                                                  ),
                                            ),

                                            const SizedBox(width: 10),

                                            Expanded(
                                              child: Text(
                                                standing.team.name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      _stat(standing.all.played),
                                      _stat(standing.all.win),
                                      _stat(standing.all.draw),
                                      _stat(standing.all.lose),

                                      SizedBox(
                                        width: 40,
                                        child: Text(
                                          standing.goalsDiff > 0
                                              ? "+${standing.goalsDiff}"
                                              : standing.goalsDiff.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: standing.goalsDiff >= 0
                                                ? Colors.green
                                                : Colors.red,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        width: 40,
                                        child: Text(
                                          standing.points.toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AlertErr(
              title: "Bloc State Error!",
              button1: "Refresh",
              but1_cal: () {
                context.read<StandingBloc>().add(
                  StandingRequested(
                    leagueId: widget.leagueId,
                    season: widget.season,
                  ),
                );
              },
              but1_bg: AppTheme.success,
            ),
          ],
        );
      },
    );
  }
}

Widget _stat(int value) {
  return SizedBox(
    width: 28,
    child: Text(
      value.toString(),
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white),
    ),
  );
}

Color getZoneColor(String? description) {
  if (description == null || description.trim().isEmpty) {
    return Colors.white;
  }

  final text = description.toLowerCase();

  if (text.contains("relegation")) {
    return const Color(0xFFE53935);
  }

  if (text.contains("promotion") ||
      text.contains("champions") ||
      text.contains("europa") ||
      text.contains("conference") ||
      text.contains("playoff")) {
    return const Color(0xFF43A047);
  }

  return Colors.white;
}
