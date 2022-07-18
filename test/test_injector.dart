import 'package:dicoding_tv_series/domain/usecase/get_popular_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_popular_bloc/movie_popular_bloc_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

init() {
  // Register services and blocs
  sl.registerFactory(() => MoviePopularBlocBloc(sl()));
  sl.registerLazySingleton(() => GetPopularMovie(sl()));
}

  // group("Test return data source", () {
  //   testMovieLocalSource.main();
  //   testMovieOnlineSource.main();
  // });
  // group("test  return usecase", () {
  //   getPopularMoviesUsecase.main();
  //   getRatedMoviesUsecase.main();
  //   getCastMoviesUsecase.main();
  //   searchMoviesUsecase.main();
  //   watchlistMoviesUsecase.main();
  // });

