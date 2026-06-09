import 'package:flutter/material.dart';
import 'package:matchup/core/app_constants/app_theme.dart';
import '../../domain/entities/game.dart';

class GetGameStatistics extends StatefulWidget {
  final OneResponse game;

  const GetGameStatistics({
    super.key,
    required this.game,
  });

  @override
  State<GetGameStatistics> createState() => _GetGameStatisticsState();
}

class _GetGameStatisticsState extends State<GetGameStatistics> {
  @override
  Widget build(BuildContext context) {
    if (widget.game.statistics == null ||
        widget.game.statistics!.length < 2) {
      return const Center(
        child: Text("Statistics not available"),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
      itemCount: widget.game.statistics![0].statistics?.length ?? 0,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final home =
        widget.game.statistics![0].statistics![index];

        final away =
        widget.game.statistics![1].statistics![index];

        return StatistikTile(
          teamHome: home,
          teamAway: away,
        );
      },
    );
  }
}

class StatistikTile extends StatelessWidget {
  final OneStatistic teamHome;
  final OneStatistic teamAway;

  const StatistikTile({
    super.key,
    required this.teamHome,
    required this.teamAway,
  });

  double statToDouble(dynamic value) {
    if (value == null) return 0;

    if (value is int) return value.toDouble();

    if (value is double) return value;

    if (value is String) {
      return double.tryParse(
        value.replaceAll('%', '').trim(),
      ) ??
          0;
    }

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final homeValue = statToDouble(teamHome.value);
    final awayValue = statToDouble(teamAway.value);

    final total = homeValue + awayValue;

    final homePercent =
    total == 0 ? 50.0 : (homeValue / total) * 100;

    final awayPercent =
    total == 0 ? 50.0 : (awayValue / total) * 100;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.textPrimaryLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            teamHome.type ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              SizedBox(
                width: 45,
                child: Text(
                  "${teamHome.value ?? 0}",
                  textAlign: TextAlign.center,
                ),
              ),

              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Row(
                    children: [
                      Expanded(
                        flex: homePercent.round(),
                        child: Container(
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppTheme.accentRed,
                            borderRadius: BorderRadius.circular(99)
                          ),
                        ),
                      ),
                      SizedBox(width: 4,),
                      Expanded(
                        flex: awayPercent.round(),
                        child: Container(
                          height: 10,
                          decoration: BoxDecoration(
                              color: AppTheme.primaryGreen,
                              borderRadius: BorderRadius.circular(99)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                width: 45,
                child: Text(
                  "${teamAway.value ?? 0}",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}