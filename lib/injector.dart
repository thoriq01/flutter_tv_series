import 'package:dicoding_tv_series/data/repository/movie_model_repository.dart';
import 'package:dicoding_tv_series/data/source/local/movie_local_source.dart';
import 'package:dicoding_tv_series/data/source/online/movie_online_data_source.dart';
import 'package:dicoding_tv_series/domain/repositories/movie_repositorie.dart';
import 'package:dicoding_tv_series/domain/usecase/get_cast_movie.dart';
import 'package:dicoding_tv_series/domain/usecase/get_detail_movie.dart';
import 'package:dicoding_tv_series/domain/usecase/get_now_playing_movie.dart';
import 'package:dicoding_tv_series/domain/usecase/get_popular_movie.dart';
import 'package:dicoding_tv_series/domain/usecase/get_recomendation_movie.dart';
import 'package:dicoding_tv_series/domain/usecase/get_top_rated_movie.dart';
import 'package:dicoding_tv_series/domain/usecase/search_movie.dart';
import 'package:dicoding_tv_series/domain/usecase/watchlist_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_cast_bloc/movie_cast_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_now_playing_bloc/movie_now_playing_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_popular_bloc/movie_popular_bloc_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_recomendation_bloc/movie_recomendation_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_search_bloc/movie_search_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_top_rated_bloc/movie_top_rated_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_watchlist_bloc/movie_wathclist_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'data/source/local/movies_local_data_source.dart';

final sl = GetIt.instance;

void init() {
  // Register services and blocs
  sl.registerFactory(() => MoviePopularBlocBloc(sl()));
  sl.registerFactory(() => MovieTopRatedBloc(sl()));
  sl.registerFactory(() => MovieSearchBloc(sl()));
  sl.registerFactory(() => MovieDetailBloc(sl()));
  sl.registerFactory(() => MovieCastBloc(sl()));
  sl.registerFactory(() => MovieWathclistBloc(sl()));
  sl.registerFactory(() => MovieNowPlayingBloc(sl()));
  sl.registerFactory(() => MovieRecomendationBloc(sl()));

  sl.registerLazySingleton(() => GetPopularMovie(sl()));
  sl.registerLazySingleton(() => GetTopRatedMovie(sl()));
  sl.registerLazySingleton(() => GetMovieCast(sl()));
  sl.registerLazySingleton(() => SearchMovie(sl()));
  sl.registerLazySingleton(() => GetDetailMovie(sl()));
  sl.registerLazySingleton(() => WatchListsMovie(sl()));
  sl.registerLazySingleton(() => GetRecomendation(sl()));
  sl.registerLazySingleton(() => GetNowPlaying(sl()));

  sl.registerLazySingleton<MovieRepository>(() => MovieModelRepository(sl(), sl()));
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  sl.registerLazySingleton(() => MovieDataSource(client: sl()));
  sl.registerLazySingleton(() => MovieLocalSource(sl()));
}
