import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:matchup/core/app_constants/app_theme.dart';
import 'package:matchup/features/league/presentation/bloc/all_leagues/all_leagues_bloc.dart';
import 'package:matchup/features/league/presentation/pages/league_page.dart';
import 'package:matchup/features/league/presentation/widgets/alert.dart';

import '../../domain/entities/one_league.dart';

class SearchLeague extends StatefulWidget {
  const SearchLeague({super.key});

  @override
  State<SearchLeague> createState() => _SearchLeagueState();
}

class _SearchLeagueState extends State<SearchLeague> {
  @override
  void initState() {
    super.initState();
    context.read<AllLeaguesBloc>().add(AllLeaguesRequested());
  }

  void _onLeagueSearchChenged(String query) {
    if (query.trim().isEmpty) {
      context.read<AllLeaguesBloc>().add(AllLeaguesRequested());
    } else if (query.trim().length > 2) {
      context.read<AllLeaguesBloc>().add(
        SearchLeaguesRequested(query: query.trim()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(bottom: 4),
            color: AppTheme.backgroundDark,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: context.pop,
                      icon: Icon(Icons.home_rounded, size: 32),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceDark,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: TextField(
                          onChanged: _onLeagueSearchChenged,
                          autofocus: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                              left: 12,
                              right: 12,
                              bottom: 4,
                            ),
                            hintText: "Search leagues",
                            border: InputBorder.none,
                            hintStyle: AppTheme.grayMedium,
                          ),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: BlocBuilder<AllLeaguesBloc, AllLeaguesState>(
              builder: (context, state) {
                if (state is AllLeaguesInitial || state is AllLeaguesLoading) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 5,
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                    ],
                  );
                }
                ;

                if (state is AllLeaguesError) {
                  return AlertErr(
                    title: state.message,
                    button1: "Refresh",
                    but1_bg: AppTheme.primaryGreen,
                    but1_cal: () {
                      context.read<AllLeaguesBloc>().add(AllLeaguesRequested());
                    },
                  );
                }

                if (state is AllLeaguesLoaded) {
                  final leagues = state.leaguees.response;
                  if (leagues.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AlertErr(title: "This is not a league issue."),
                      ],
                    );
                  } else {
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      itemCount: leagues.length,
                      separatorBuilder: (context, index) => SizedBox(height: 5),
                      itemBuilder: (_, index) {
                        final league = leagues[index];
                        return _listTile(league: league, context: context, season: league.seasons.last.year);
                      },
                    );
                  }
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [AlertErr(title: "Bloc State error!")],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget _listTile({required OneLeaguee league, required int season, context}) {
  return ListTile(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LeaguePage(id: league.league.id, season: season,),
        ),
      );
    },
    tileColor: AppTheme.surfaceDark,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(14),
    ),
    leading: Container(
      width: 45,
      height: 45,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.textMutedLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
        clipBehavior: Clip.antiAlias,
        child: Image.network(league.league.logo, fit: BoxFit.scaleDown),
      ),
    ),
    title: Text(league.league.name),
    subtitle: Text(league.country.name),
    trailing: Icon(Icons.navigate_next_rounded),
  );
}
