import 'package:anime_red/config/api/base_url.dart';
import 'package:anime_red/injector/injector.dart';
import 'package:anime_red/presentation/bloc/home/home_bloc.dart';
import 'package:anime_red/presentation/bloc/recent_anime/recent_anime_bloc.dart';
import 'package:anime_red/presentation/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/config.dart';

void main() async {
  await initDependancies();
  runApp(const MainApp());
}

Future<void> initDependancies() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO NATIVE SPLASH

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: AppColors.black, // navigation bar color
    statusBarColor: AppColors.black, // status bar color
    statusBarIconBrightness: Brightness.light,
  ));

  BuildConfig.instantiate(
    environment: EvnType.dev,
    appName: "AnimeRed",
    baseUrl: LIVE_SERVER,
    requestTimeOut: const Duration(seconds: 15),
  );

  await configureInjection();
  // TODO CLOSE NATIVE SPLASH
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<HomeBloc>()),
        BlocProvider(create: (_) => getIt<RecentAnimeBloc>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 800),
        splitScreenMode: true,
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(
              fontFamily: "Comic Neue",
              scaffoldBackgroundColor: AppColors.black,
            ),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRouter.ongeneratedRoute,
            initialRoute: AppRouter.HOME_SCREEN,
          );
        },
      ),
    );
  }
}
