// ignore_for_file: use_build_context_synchronously

import 'package:anime_red/config/constants/assets.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {});

    return Scaffold(
      body: Center(
        child: Image.asset(
          AppImageAssets.splashLogo,
        ),
      ),
    );
  }
}
