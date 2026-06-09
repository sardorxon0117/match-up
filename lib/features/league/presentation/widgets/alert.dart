import 'package:flutter/material.dart';
import 'package:matchup/features/league/domain/entities/one_league.dart';

import '../../../../core/app_constants/app_theme.dart';

class AlertErr extends StatelessWidget {
  String title;
  String? button1;
  String? button2;
  String? button3;
  VoidCallback? but1_cal;
  VoidCallback? but2_cal;
  VoidCallback? but3_cal;
  Color? but1_bg;
  Color? but2_bg;
  Color? but3_bg;
  Color? but1_tx;
  Color? but2_tx;
  Color? but3_tx;

  AlertErr({
    super.key,
    required this.title,
    this.button1,
    this.button2,
    this.button3,
    this.but1_cal,
    this.but2_cal,
    this.but3_cal,
    this.but1_bg = Colors.white,
    this.but2_bg = Colors.white,
    this.but3_bg = Colors.white,
    this.but1_tx = Colors.black,
    this.but2_tx = Colors.black,
    this.but3_tx = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 4),
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: AppTheme.error,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(child: Text(title, style: AppTheme.tileTeam)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              if (button1 != null)
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: but1_bg,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: but1_cal,
                    child: Text(
                      button1!,
                      style: TextStyle(color: but1_tx, fontSize: 14),
                    ),
                  ),
                ),
              if (button2 != null) SizedBox(width: 8),
              if (button2 != null)
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: but2_bg,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: but2_cal,
                    child: Text(
                      button2!,
                      style: TextStyle(color: but2_tx, fontSize: 14),
                    ),
                  ),
                ),
              if (button3 != null) SizedBox(width: 8),
              if (button3 != null)
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: but3_bg,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: but3_cal,
                    child: Text(
                      button3!,
                      style: TextStyle(color: but3_tx, fontSize: 14),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

Future<int?> showYearSelectBar(BuildContext context, int lastSeason, List<Season> seasons) async {
  return await showDialog<int>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Mavsumni tanlang"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: seasons.map((Season season) {
              return ListTile(
                title: Text(
                  season.year.toString(),
                  style: TextStyle(
                    fontWeight: season.year == lastSeason ? FontWeight.bold : FontWeight.normal,
                    color: season.year == lastSeason ? Colors.blue : AppTheme.textMutedDark,
                  ),
                ),
                trailing: season.year == lastSeason ? const Icon(Icons.check, color: Colors.blue) : null,
                onTap: () {
                  Navigator.pop(context, season.year);
                },
              );
            }).toList(),
          ),
        ),
      );
    },
  );
}