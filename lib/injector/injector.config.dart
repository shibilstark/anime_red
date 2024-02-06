// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/anime/anime_repository_impl/anime_repository_impl.dart' as _i4;
import '../data/database/app_db_repository_impl.dart' as _i7;
import '../domain/anime/anime_repository/anime_respository.dart' as _i3;
import '../domain/database/database_repository.dart' as _i6;
import '../presentation/bloc/anime/anime_bloc.dart' as _i10;
import '../presentation/bloc/anime_search/anime_search_bloc.dart' as _i5;
import '../presentation/bloc/home/home_bloc.dart' as _i8;
import '../presentation/bloc/recent_anime/recent_anime_bloc.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.AnimeRepository>(() => _i4.AnimeRepositoryImpl());
  gh.factory<_i5.AnimeSearchBloc>(
      () => _i5.AnimeSearchBloc(get<_i3.AnimeRepository>()));
  gh.lazySingleton<_i6.AppDbRepository>(
      () => _i7.AppDbRepositoryImplementation());
  gh.factory<_i8.HomeBloc>(() => _i8.HomeBloc(get<_i3.AnimeRepository>()));
  gh.factory<_i9.RecentAnimeBloc>(
      () => _i9.RecentAnimeBloc(get<_i3.AnimeRepository>()));
  gh.factory<_i10.AnimeBloc>(() => _i10.AnimeBloc(get<_i3.AnimeRepository>()));
  return get;
}
