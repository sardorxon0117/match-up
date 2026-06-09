import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchup/core/app_constants/app_theme.dart';
import 'package:matchup/core/app_constants/image_const.dart';
import 'package:matchup/core/router/app_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      context.go(AppRouter.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Center(
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Center(child: Image.asset(ImageConst.logo)),
                ),
              ),
              Center(
                child: CircularProgressIndicator(
                  color: AppTheme.primaryGreen,
                  strokeWidth: 7,
                  strokeCap: StrokeCap.round,
                  strokeAlign: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
