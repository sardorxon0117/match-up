import 'package:flutter/material.dart';
import 'package:matchup/core/app_constants/app_theme.dart';
import 'package:matchup/core/app_constants/image_const.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  Future<void> _openLink(link) async {
    final Uri url = Uri.parse(link);

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Havola ochilmadi: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 12, vertical: 8),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppTheme.surfaceDark,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("About MatchUP", style: AppTheme.heading2),
                    SizedBox(height: 15),
                    Text("MatchUP is a modern platform designed for football fans. With MatchUP, you can follow the world's most popular leagues, teams, and matches in real time.\nThe app provides live scores, detailed match statistics, team lineups, league standings, and many other essential football insights in a fast and convenient way. Thanks to its intuitive design and high performance, you can access the information you need within seconds.\n\nKey Features:\n• Live match scores and updates\n• Detailed match statistics\n• League tables and tournament standings\n• Team and player information\n• Modern Dark Mode interface\n• Fast and user-friendly navigation\n\nMatchUP is your reliable companion for staying connected to the world of football, bringing everything you need into one place.")
                  ],
                ),
              ),
              SizedBox(height: 8,),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: AppTheme.dividerDark,
                        overlayColor: AppTheme.primaryGreen,
                      ),
                      onPressed: () {
                        _openLink("https://www.instagram.com/matchup_1/");
                      },
                      child: Text("Instagram"),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: AppTheme.dividerDark,
                        overlayColor: AppTheme.primaryGreen,
                      ),
                      onPressed: () {
                        _openLink('https://match-up-web.netlify.app/');
                      },
                      child: Text("Web Site"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(12),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppTheme.surfaceDark,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Author", style: AppTheme.heading2),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(
                            ImageConst.my_image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Sardorxon", style: AppTheme.heading2),
                            Text("Valiyev", style: AppTheme.heading2),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(12),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppTheme.surfaceDark,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Social Media", style: AppTheme.heading2),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: AppTheme.dividerDark,
                              overlayColor: AppTheme.primaryGreen,
                            ),
                            onPressed: () {
                              _openLink("https://www.instagram.com/sardorxonvaliyev/");
                            },
                            child: Text("Instagram"),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: AppTheme.dividerDark,
                              overlayColor: AppTheme.primaryGreen,
                            ),
                            onPressed: () {
                              _openLink('https://t.me/sardorxon_valiyev');
                            },
                            child: Text("Telegram"),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: AppTheme.dividerDark,
                              overlayColor: AppTheme.primaryGreen,
                            ),
                            onPressed: () {
                              _openLink('https://my-social-networks.netlify.app/');
                            },
                            child: Text("Web Site"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14,),
              Center(child: Text("© 2026 MatchUP. All rights reserved."))
            ],
          ),
        ),
      ),
    );
  }
}
