// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/anime/anime_repository_impl/anime_repository_impl.dart' as _i4;
import '../domain/anime/anime_repository/anime_respository.dart' as _i3;
import '../presentation/bloc/anime/anime_bloc.dart' as _i8;
import '../presentation/bloc/anime_search/anime_search_bloc.dart' as _i5;
import '../presentation/bloc/home/home_bloc.dart' as _i6;
import '../presentation/bloc/recent_anime/recent_anime_bloc.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i3.AnimeRepository>(() => _i4.AnimeRepositoryImpl());
  gh.factory<_i5.AnimeSearchBloc>(
      () => _i5.AnimeSearchBloc(get<_i3.AnimeRepository>()));
  gh.factory<_i6.HomeBloc>(() => _i6.HomeBloc(get<_i3.AnimeRepository>()));
  gh.factory<_i7.RecentAnimeBloc>(
      () => _i7.RecentAnimeBloc(get<_i3.AnimeRepository>()));
  gh.factory<_i8.AnimeBloc>(() => _i8.AnimeBloc(get<_i3.AnimeRepository>()));
  return get;
}
