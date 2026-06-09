import 'package:flutter/material.dart';
import 'package:matchup/core/app_constants/app_theme.dart';
import 'package:matchup/features/players/presentation/pages/player_profile.dart';
import '../../domain/entities/game.dart';

class MatchLineups extends StatefulWidget {
  final OneResponse game;

  const MatchLineups({
    super.key,
    required this.game,
  });

  @override
  State<MatchLineups> createState() => _MatchLineupsState();
}

class _MatchLineupsState extends State<MatchLineups> {
  bool isHome = true;

  @override
  Widget build(BuildContext context) {

    final lineup = widget.game.lineups![isHome ? 0 : 1];

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            height: 42,
            decoration: BoxDecoration(
              color: AppTheme.surfaceDark,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isHome = true;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(
                        milliseconds: 250,
                      ),
                      decoration: BoxDecoration(
                        color: isHome
                            ? AppTheme.primaryGreen
                            : Colors.transparent,
                        borderRadius:
                        BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        widget.game.teams.home.name ??
                            "Home",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isHome = false;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(
                        milliseconds: 250,
                      ),
                      decoration: BoxDecoration(
                        color: !isHome
                            ? AppTheme.primaryGreen
                            : Colors.transparent,
                        borderRadius:
                        BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        widget.game.teams.away.name ??
                            "Away",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          Text(
            "Formation: ${lineup.formation ?? "-"}",
            style: AppTheme.bodyLarge
          ),

          SizedBox(height: 25),

          Text(
            "Coach",
            style: AppTheme.heading2,
          ),

          SizedBox(height: 10),

          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.surfaceDark,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                  (lineup.coach.photo != null &&
                      lineup.coach.photo!
                          .isNotEmpty)
                      ? NetworkImage(
                    lineup.coach.photo!,
                  )
                      : null,
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    lineup.coach.name ??
                        "Unknown Coach",
                    style: AppTheme.heading2,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 25),

          Text(
            "Starting XI",
            style: AppTheme.heading2,
          ),

          SizedBox(height: 10),

          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount:
            lineup.startXi?.length ?? 0,
            itemBuilder: (context, index) {
              final player = lineup.startXi![index].player;

              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: AppTheme.surfaceDark
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerProfilePage(playerId: player.id!)));
                  },
                  leading: Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network('https://media.api-sports.io/football/players/${player.id}.png'),
                  ),
                  title: Text(
                    player.name ?? "",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    "${player.pos ?? ""} • ${player.grid ?? ""}",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  trailing: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        color: AppTheme.surfaceElevatedDark,
                        borderRadius: BorderRadius.circular(99)
                    ),
                    child: Center(child: Text(player.number!.toString())),
                  ),
                ),
              );
            }, separatorBuilder: (BuildContext context, int index) => SizedBox(height: 8,),
          ),

          SizedBox(height: 25),

          Text(
            "Substitutes",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 10),

          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics:
            NeverScrollableScrollPhysics(),
            itemCount:
            lineup.substitutes?.length ?? 0,
            itemBuilder: (context, index) {
              final player =
                  lineup.substitutes![index].player;

              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppTheme.surfaceDark
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerProfilePage(playerId: player.id!)));
                  },
                  leading: Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network('https://media.api-sports.io/football/players/${player.id}.png'),
                  ),
                  title: Text(
                    player.name ?? "",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    "${player.pos ?? ""} • ${player.grid ?? ""}",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  trailing: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceElevatedDark,
                      borderRadius: BorderRadius.circular(99)
                    ),
                    child: Center(child: Text(player.number!.toString())),
                  ),
                ),
              );
            }, separatorBuilder: (BuildContext context, int index) => SizedBox(height: 8,),
          ),

          SizedBox(height: 30),
        ],
      ),
    );
  }
}