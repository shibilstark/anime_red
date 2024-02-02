import 'package:anime_red/presentation/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/config.dart';

void main() async {
  await initDependancies();
  runApp(const MainApp());
}

Future<void> initDependancies() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: AppColors.black, // navigation bar color
    statusBarColor: AppColors.black, // status bar color
    statusBarIconBrightness: Brightness.light,
  ));

  BuildConfig.instantiate(
    environment: EvnType.dev,
    appName: "AnimeRed",
    baseUrl: "http://localhost:3000/",
    requestTimeOut: const Duration(seconds: 15),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(fontFamily: "Comic Neue"),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.ongeneratedRoute,
          initialRoute: AppRouter.LANDING_SCREEN,
        );
      },
    );
  }
}
