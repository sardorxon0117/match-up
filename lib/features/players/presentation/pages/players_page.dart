import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:matchup/core/app_constants/app_theme.dart';
import 'package:matchup/core/router/app_router.dart';
import 'package:matchup/features/league/presentation/widgets/alert.dart';
import 'package:matchup/features/players/domain/entitys/one_player.dart';
import 'package:matchup/features/players/presentation/bloc/all_players/all_players_bloc.dart';
import 'package:matchup/features/players/presentation/pages/player_profile.dart';

import '../../../../core/app_constants/image_const.dart';


class PlayersPage extends StatefulWidget {
  const PlayersPage({super.key});

  @override
  State<PlayersPage> createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  @override
  void initState() {
    super.initState();
    context.read<AllPlayersBloc>().add(AllPlayersRequested());
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
                    Image.asset(ImageConst.logo,width: 42,),
                    SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceDark,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: GestureDetector(
                          onTap: (){
                            context.push(AppRouter.search_player);
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
                                Text("Search players", style: AppTheme.grayMedium),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: BlocBuilder<AllPlayersBloc, AllPlayersState>(
              builder: (context, state) {
                if (state is AllPlayersInitial || state is AllPlayersLoading) {
                  return RefreshIndicator.adaptive(
                    onRefresh: () async {
                      context.read<AllPlayersBloc>().add(AllPlayersRequested());
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

                if (state is AllPlayersError) {
                  return AlertErr(
                    title: state.message,
                    button1: "Refresh",
                    but1_bg: AppTheme.primaryGreen,
                    but1_cal: () {
                      context.read<AllPlayersBloc>().add(AllPlayersRequested());
                    },
                  );
                }

                if (state is AllPlayersLoaded) {
                  final players = state.players.response;
                  if (players.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AlertErr(title: "This is not a player issue."),
                      ],
                    );
                  } else {
                    return RefreshIndicator.adaptive(
                      onRefresh: () async {
                        context.read<AllPlayersBloc>().add(AllPlayersRequested());
                      },
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        itemCount: players.length,
                        separatorBuilder: (context, index) => SizedBox(height: 5),
                        itemBuilder: (_, index) {
                          final player = players[index];
                          return _listTile(player: player.player, context: context);
                        },
                      ),
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

Widget _listTile({required Player player, context}) {
  return ListTile(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlayerProfilePage(playerId: player.id),
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
        child: Image.network(player.photo, fit: BoxFit.scaleDown),
      ),
    ),
    title: Text(player.name),
    subtitle: Text(player.position!),
    trailing: Icon(Icons.navigate_next_rounded),
  );
}
