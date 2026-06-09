import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:matchup/core/app_constants/app_theme.dart';
import 'package:matchup/features/league/presentation/widgets/alert.dart';
import 'package:matchup/features/players/domain/entitys/one_player.dart';
import 'package:matchup/features/players/presentation/bloc/all_players/all_players_bloc.dart';
import 'package:matchup/features/players/presentation/pages/player_profile.dart';


class SearchPlayerPage extends StatefulWidget {
  const SearchPlayerPage({super.key});

  @override
  State<SearchPlayerPage> createState() => _SearchPlayerPageState();
}

class _SearchPlayerPageState extends State<SearchPlayerPage> {
  @override
  void initState() {
    super.initState();
    context.read<AllPlayersBloc>().add(AllPlayersRequested());
  }

  void _onPlayerSearchChenged(String query) {
    if (query.trim().isEmpty) {
      context.read<AllPlayersBloc>().add(AllPlayersRequested());
    } else if (query.trim().length > 2) {
      context.read<AllPlayersBloc>().add(
        SearchPlayersRequested(query: query.trim()),
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
                          onChanged: _onPlayerSearchChenged,
                          autofocus: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                              left: 12,
                              right: 12,
                              bottom: 4,
                            ),
                            hintText: "Search player",
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
            child: BlocBuilder<AllPlayersBloc, AllPlayersState>(
              builder: (context, state) {
                if (state is AllPlayersInitial || state is AllPlayersLoading) {
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

                if (state is AllPlayersError) {
                  return AlertErr(
                    title: state.message,
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
                    return ListView.separated(
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
