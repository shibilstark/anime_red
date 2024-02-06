// ignore_for_file: non_constant_identifier_names

import 'package:anime_red/config/api/base_url.dart';
import 'package:anime_red/domain/database/database_repository.dart';
import 'package:anime_red/injector/injector.dart';
import 'package:anime_red/presentation/bloc/anime_search/anime_search_bloc.dart';
import 'package:anime_red/presentation/bloc/home/home_bloc.dart';
import 'package:anime_red/presentation/bloc/recent_anime/recent_anime_bloc.dart';
import 'package:anime_red/presentation/router/router.dart';
import 'package:anime_red/utils/preference/preference_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/config.dart';
import 'presentation/bloc/anime/anime_bloc.dart';

void main() async {
  await initDependancies();
  runApp(const MainApp());
}

Future<void> initDependancies() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

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
  await getIt<AppDbRepository>().initializeDB();

  IS_LAUNCHED_BEFORE = await PreferenceUtil.getIsInitiallyLaunched();

  FlutterNativeSplash.remove();
}

late bool IS_LAUNCHED_BEFORE;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<HomeBloc>()),
        BlocProvider(create: (_) => getIt<RecentAnimeBloc>()),
        BlocProvider(create: (_) => getIt<AnimeSearchBloc>()),
        BlocProvider(create: (_) => getIt<AnimeBloc>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 800),
        splitScreenMode: true,
        minTextAdapt: true,
        builder: (context, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<HomeBloc>().add(const HomeLoadData());
            context.read<RecentAnimeBloc>().add(const RecentAnimeLoadData());
          });
          return MaterialApp(
            theme: ThemeData(
              fontFamily: "Comic Neue",
              scaffoldBackgroundColor: AppColors.black,
            ),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRouter.ongeneratedRoute,
            initialRoute: IS_LAUNCHED_BEFORE
                ? AppRouter.HOME_SCREEN
                : AppRouter.LANDING_SCREEN,
          );
        },
      ),
    );
  }
}
