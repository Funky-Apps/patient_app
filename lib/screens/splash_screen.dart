import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/constants.dart';
import '../routes/routes_name.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late String _appVersion = ''; // Initialize with default value
  bool _showLanguageSelection = false; // To toggle language selection display

  @override
  void initState() {
    // Delay for 3 seconds and check the login status
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, RoutesName.selectDoctor);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Stack(
          children: [
            // Main content
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(Constants.appLogo, width: 200),
                        SizedBox(
                          height: 25,
                        ),
                        const Text(
                          'Health Mob',
                          style: TextStyle(
                            color: AppColors.blueColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Conditionally display either the language selection or the default content

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
