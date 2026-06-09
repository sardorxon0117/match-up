import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:matchup/core/app_constants/app_theme.dart';
import 'package:matchup/features/about/presentation/pages/about_page.dart';
import 'package:matchup/features/home/presentation/pages/get_all_games_date.dart';
import 'package:matchup/features/home/presentation/pages/get_all_games_today.dart';
import 'package:matchup/features/players/presentation/pages/players_page.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    GetAllGamesToday(),
    GetAllGamesDate(),
    PlayersPage(),
    AboutPage()
  ];

  final List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.sports_soccer_rounded),
      activeIcon: Icon(Icons.sports_soccer_sharp),
      label: "Today",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.date_range_outlined),
      activeIcon: Icon(Icons.date_range_rounded),
      label: "Games",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      activeIcon: Icon(Icons.person),
      label: "Players",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.crisis_alert_rounded),
      activeIcon: Icon(Icons.crisis_alert_rounded),
      label: "About",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0, left: 20, right: 20),
          child: MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            child: Container(
              clipBehavior: Clip.antiAlias,
              padding: EdgeInsets.all(2),
              height: 82,
              decoration: BoxDecoration(
                color: AppTheme.backgroundDark,
                borderRadius: BorderRadius.circular(999),
                border: Border(
                  top: BorderSide(color: AppTheme.textMutedLight, width: 1),
                  left: BorderSide(color: AppTheme.textMutedLight, width: 1),
                ),
              ),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  showSelectedLabels: true,
                  showUnselectedLabels: false,
                  selectedLabelStyle: TextStyle(
                    color: AppTheme.primaryGreen,
                    fontSize: 12,
                  ),
                  selectedItemColor: AppTheme.primaryGreenLight,
                  unselectedItemColor: Colors.white,
                  currentIndex: _currentIndex,
                  onTap: (index) => setState(() => _currentIndex = index),
                  items: _items,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
