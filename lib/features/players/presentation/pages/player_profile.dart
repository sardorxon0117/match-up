import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchup/core/app_constants/app_theme.dart';
import 'package:matchup/features/players/domain/entitys/player_team.dart';
import 'package:matchup/features/players/presentation/bloc/player_teams/player_teams_bloc.dart';
import 'package:matchup/features/players/presentation/bloc/single_player/single_player_bloc.dart';
import 'package:matchup/features/team/presentation/pages/team_page.dart';

import '../../../league/presentation/widgets/alert.dart';

class PlayerProfilePage extends StatefulWidget {
  int playerId;

  PlayerProfilePage({super.key, required this.playerId});

  @override
  State<PlayerProfilePage> createState() => _PlayerProfilePageState();
}

class _PlayerProfilePageState extends State<PlayerProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<SinglePlayerBloc>().add(
      SinglePlayerRequested(playerId: widget.playerId),
    );
    context.read<PlayerTeamsBloc>().add(
      PlayerTeamsRequested(playerId: widget.playerId),
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
      body: BlocBuilder<SinglePlayerBloc, SinglePlayerState>(
        builder: (context, state) {
          if (state is SinglePlayerInitial || state is SinglePlayerLoading) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 5,
                strokeCap: StrokeCap.round,
              ),
            );
          }

          if (state is SinglePlayerError) {
            return AlertErr(
              title: state.message,
              button1: "Refresh",
              but1_bg: AppTheme.primaryGreen,
              but1_cal: () {
                context.read<SinglePlayerBloc>().add(
                  SinglePlayerRequested(playerId: widget.playerId),
                );
                context.read<PlayerTeamsBloc>().add(
                  PlayerTeamsRequested(playerId: widget.playerId),
                );
              },
            );
          }

          if (state is SinglePlayerLoaded) {
            final player = state.player.response[0];

            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
                  color: AppTheme.surfaceDark,
                  width: double.infinity,
                  height: 100,
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
                                      player.player.photo,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 14),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${player.player.firstname} ${player.player.lastname}",
                                        style: AppTheme.heading2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        player.player.position.toString(),
                                        style: AppTheme.bodyLarge,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(14),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: AppTheme.surfaceDark,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Nationality:",
                                      style: AppTheme.bodyLarge,
                                    ),
                                    Text(
                                      player.player.nationality.toString(),
                                      style: AppTheme.bodyLarge,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 14),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Birth Place:",
                                      style: AppTheme.bodyLarge,
                                    ),
                                    Text(
                                      "${player.player.birth!.country}, ${player.player.birth!.place}",
                                      style: AppTheme.bodyLarge,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 14),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Birth Date:",
                                      style: AppTheme.bodyLarge,
                                    ),
                                    Text(
                                      "${player.player.birth!.date!.day}/${player.player.birth!.date!.month}/${player.player.birth!.date!.year}",
                                      style: AppTheme.bodyLarge,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 14),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Age:", style: AppTheme.bodyLarge),
                                    Text(
                                      "${player.player.age}",
                                      style: AppTheme.bodyLarge,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 14),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Height:", style: AppTheme.bodyLarge),
                                    Text(
                                      "${player.player.height}",
                                      style: AppTheme.bodyLarge,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 14),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Weight:", style: AppTheme.bodyLarge),
                                    Text(
                                      "${player.player.weight}",
                                      style: AppTheme.bodyLarge,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 14),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Number:", style: AppTheme.bodyLarge),
                                    Text(
                                      "${player.player.number}",
                                      style: AppTheme.bodyLarge,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 14),
                          BlocBuilder<PlayerTeamsBloc, PlayerTeamsState>(
                            builder: (context, state) {
                              if (state is PlayerTeamsInitial || state is PlayerTeamsLoading) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 5,
                                    strokeCap: StrokeCap.round,
                                  ),
                                );
                              }
                              if (state is PlayerTeamsError) {
                                return AlertErr(
                                  title: state.message,
                                  button1: "Refresh",
                                  but1_bg: AppTheme.primaryGreen,
                                  but1_cal: () {
                                    context.read<SinglePlayerBloc>().add(
                                      SinglePlayerRequested(playerId: widget.playerId),
                                    );
                                    context.read<PlayerTeamsBloc>().add(
                                      PlayerTeamsRequested(playerId: widget.playerId),
                                    );
                                  },
                                );
                              }
                              if (state is PlayerTeamsLoaded) {
                                return Container(
                                  padding: EdgeInsets.all(14),
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    color: AppTheme.surfaceDark,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    itemCount:
                                        state.playerTeams.response.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final team =
                                          state.playerTeams.response[index];
                                      return TileTeam(team: team);
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            SizedBox(height: 14),
                                  ),
                                );
                              }

                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  AlertErr(title: "Bloc State error!"),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return Center(
            child: AlertErr(
              title: "Bloc State error!",
              button1: "Refresh",
              but1_cal: () {
                context.read<SinglePlayerBloc>().add(
                  SinglePlayerRequested(playerId: widget.playerId),
                );
                context.read<PlayerTeamsBloc>().add(
                  PlayerTeamsRequested(playerId: widget.playerId),
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

class TileTeam extends StatelessWidget {
  Response team;

  TileTeam({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TeamPage(teamId: team.team.id),
          ),
        );
      },
      child: Container(
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  child: Image.network(team.team.logo),
                ),
                SizedBox(width: 12),
                Text("${team.team.name}", overflow: TextOverflow.ellipsis),
              ],
            ),
            Text(
              team.seasons.isNotEmpty
                  ? "${team.seasons.last} - ${team.seasons.first}"
                  : "",
            ),
          ],
        ),
      ),
    );
  }
}
