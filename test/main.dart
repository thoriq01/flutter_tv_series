import 'package:dicoding_tv_series/domain/usecase/get_popular_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_popular_bloc/movie_popular_bloc_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'data/test_movie_local_source.dart' as testMovieLocalSource;
import 'data/test_movie_online_source.dart' as testMovieOnlineSource;
import 'usecase/get_popular_movies.dart' as getPopularMoviesUsecase;
import 'usecase/get_top_rated_movies.dart' as getRatedMoviesUsecase;
import 'usecase/get_cast_movies.dart' as getCastMoviesUsecase;
import 'usecase/search_movies.dart' as searchMoviesUsecase;
import 'usecase/watchlist_movies.dart' as watchlistMoviesUsecase;
import 'presentation/bloc/get_popular_movies_bloc.dart' as popularMoviesBloc;
import 'test_injector.dart' as ts;

void main() {
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
  group("bloc unit test", () {
    popularMoviesBloc.main();
  });
}
