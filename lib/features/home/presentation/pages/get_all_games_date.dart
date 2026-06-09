import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:matchup/core/app_constants/app_theme.dart';
import 'package:matchup/core/app_constants/image_const.dart';
import 'package:matchup/features/home/domain/entities/game.dart';
import 'package:matchup/features/home/presentation/bloc/date_games/date_games_bloc.dart';
import 'package:matchup/features/home/presentation/pages/get_all_games_today.dart';
import 'package:matchup/features/league/presentation/pages/league_page.dart';
import 'package:matchup/features/league/presentation/widgets/alert.dart';

class GetAllGamesDate extends StatefulWidget {
  const GetAllGamesDate({super.key});

  @override
  State<GetAllGamesDate> createState() => _GetAllGamesDateState();
}

class _GetAllGamesDateState extends State<GetAllGamesDate> {
  late String selectedDate;

  @override
  void initState() {
    super.initState();

    selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    context.read<DateGamesBloc>().add(DateGamesRequested(date: selectedDate));
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        selectedDate = DateFormat('yyyy-MM-dd').format(picked);
      });

      context.read<DateGamesBloc>().add(DateGamesRequested(date: selectedDate));
    }
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
          onTap: _pickDate,
          child: Container(
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppTheme.surfaceDark,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_month, color: AppTheme.textMutedDark),
                const SizedBox(width: 10),
                Text(selectedDate, style: AppTheme.grayMedium),
              ],
            ),
          ),
        ),
      ),

      body: BlocBuilder<DateGamesBloc, DateGamesState>(
        builder: (context, state) {
          if (state is DateGamesLoading || state is DateGamesInitial) {
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                context.read<DateGamesBloc>().add(
                  DateGamesRequested(date: selectedDate),
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
                context.read<DateGamesBloc>().add(DateGamesRequested(date: selectedDate));
              },
            );
          }

          if (state is DateGamesLoaded) {
            final games = state.allGames.response ?? [];

            if (games.isEmpty) {
              return AlertErr(title: "There are no games on this date!");
            }

            final Map<int, List<OneResponse>> grouped = {};

            for (final game in games) {
              final id = game.league.id ?? 0;
              grouped.putIfAbsent(id, () => []);
              grouped[id]!.add(game);
            }

            final leagueIds = grouped.keys.toList()..sort();

            return RefreshIndicator.adaptive(
              onRefresh: () async => context.read<DateGamesBloc>().add(
                DateGamesRequested(date: selectedDate),
              ),
              child: ListView.separated(
                padding: const EdgeInsets.only(
                  top: 12,
                  left: 12,
                  right: 12,
                  bottom: 120,
                ),
                itemCount: leagueIds.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final leagueId = leagueIds[index];
                  final leagueGames = grouped[leagueId]!;
                  final league = leagueGames.first.league;

                  return Container(
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceDark,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LeaguePage(
                                  id: league.id ?? 0,
                                  season: league.season!,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Image.network(
                                  league.logo ?? "",
                                  width: 32,
                                  height: 32,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        league.name ?? "",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
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

                        ...leagueGames.map((g) => GameTile(game: g)),
                      ],
                    ),
                  );
                },
              ),
            );
          }

          return AlertErr(title: "Unknown situation");
        },
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: AlertErr(
        title: "An error occurred.\nPlease try again!",
        but1_cal: () {
          context.read<DateGamesBloc>().add(
            DateGamesRequested(date: selectedDate),
          );
        },
        but1_bg: AppTheme.primaryGreen,
      ),
    );
  }
}
