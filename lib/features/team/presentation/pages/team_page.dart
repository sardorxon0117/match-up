import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchup/core/app_constants/app_theme.dart';
import 'package:matchup/features/team/presentation/bloc/team_profile/team_profile_bloc.dart';

import '../../../league/presentation/widgets/alert.dart';

class TeamPage extends StatefulWidget {
  int teamId;

  TeamPage({super.key, required this.teamId});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  @override
  void initState() {
    super.initState();
    context.read<TeamProfileBloc>().add(
      TeamProfileRequested(teamId: widget.teamId),
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
      body: BlocBuilder<TeamProfileBloc, TeamProfileState>(
        builder: (context, state) {
          if (state is TeamProfileInitial || state is TeamProfileLoading) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 5,
                strokeCap: StrokeCap.round,
              ),
            );
          }

          if (state is TeamProfileError) {
            return AlertErr(
              title: state.message,
              button1: "Refresh",
              but1_bg: AppTheme.primaryGreen,
              but1_cal: () {
                context.read<TeamProfileBloc>().add(
                  TeamProfileRequested(teamId: widget.teamId),
                );
              },
            );
          }

          if (state is TeamProfileLoaded) {
            final team = state.team.response[0];

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
                                      team.team.logo,
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
                                        team.team.name.toString(),
                                        style: AppTheme.heading2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        team.team.country.toString(),
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
                                    Text("Founded:", style: AppTheme.bodyLarge),
                                    Text(
                                      "${team.team.founded}",
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
                                      "Team Code:",
                                      style: AppTheme.bodyLarge,
                                    ),
                                    Text(
                                      "${team.team.code}",
                                      style: AppTheme.bodyLarge,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 14),
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
                                Container(
                                  width: double.maxFinite,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Image.network(
                                    team.venue.image, fit: BoxFit.cover,
                                    errorBuilder: (context, object, track) {
                                      return Image.network(
                                          fit: BoxFit.cover,
                                          'https://thumbs.dreamstime.com/b/no-image-available-icon-sign-isolated-white-background-simple-vector-logo-no-image-available-icon-sign-isolated-white-271600521.jpg');
                                    },),
                                ),
                                SizedBox(height: 14),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Venue:", style: AppTheme.bodyLarge),
                                    SizedBox(width: 24,),
                                    Expanded(
                                      child: Text(
                                        "${team.venue.name}",
                                        style: AppTheme.bodyLarge,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 18),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "Capacity:", style: AppTheme.bodyLarge),
                                    SizedBox(width: 24,),
                                    Expanded(
                                      child: Text(
                                        "${team.venue.capacity}",
                                        style: AppTheme.bodyLarge,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 18),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Surface:", style: AppTheme.bodyLarge),
                                    SizedBox(width: 24,),
                                    Expanded(
                                      child: Text(
                                        "${team.venue.surface}",
                                        style: AppTheme.bodyLarge,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 18),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("City:", style: AppTheme.bodyLarge),
                                    SizedBox(width: 24,),
                                    Expanded(
                                      child: Text(
                                        "${team.venue.city}",
                                        style: AppTheme.bodyLarge,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 18),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Address:", style: AppTheme.bodyLarge),
                                    SizedBox(width: 24,),
                                    Expanded(
                                      child: Text(
                                        "${team.venue.address}",
                                        style: AppTheme.bodyLarge,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                context.read<TeamProfileBloc>().add(
                  TeamProfileRequested(teamId: widget.teamId),
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
