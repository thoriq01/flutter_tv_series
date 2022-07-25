import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/domain/usecase/get_now_playing_movie.dart';
import 'package:dicoding_tv_series/domain/usecase/get_popular_movie.dart';
import 'package:dicoding_tv_series/domain/usecase/get_top_rated_movie.dart';
import 'package:dicoding_tv_series/domain/usecase/search_movie.dart';
import 'package:dicoding_tv_series/domain/usecase/watchlist_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_now_playing_bloc/movie_now_playing_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_popular_bloc/movie_popular_bloc_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_recomendation_bloc/movie_recomendation_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_search_bloc/movie_search_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_top_rated_bloc/movie_top_rated_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_watchlist_bloc/movie_wathclist_bloc.dart';
import 'package:dicoding_tv_series/presentation/pages/movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../bloc/get_popular_movies_bloc.mocks.dart';

void main() {
  late MockMovieRepository _movieRepository;
  late GetPopularMovie getPopularMoviesBloc;
  late GetTopRatedMovie getTopRatedMoviesBloc;
  late GetNowPlaying getNowPlayingMoviesBloc;
  late WatchListsMovie watchListsMovie;
  late SearchMovie searchMovie;

  late MoviePopularBlocBloc _moviePopularBloc;
  late MovieNowPlayingBloc _movieNowPlayingBloc;
  late MovieTopRatedBloc _movieTopRatedBloc;
  late MovieSearchBloc _movieSearchBloc;
  late MovieWathclistBloc _movieWathclistBloc;

  setUp(() {
    _movieRepository = MockMovieRepository();
    getPopularMoviesBloc = GetPopularMovie(_movieRepository);
    getTopRatedMoviesBloc = GetTopRatedMovie(_movieRepository);
    getNowPlayingMoviesBloc = GetNowPlaying(_movieRepository);
    watchListsMovie = WatchListsMovie(_movieRepository);
    searchMovie = SearchMovie(_movieRepository);

    _moviePopularBloc = MoviePopularBlocBloc(getPopularMoviesBloc);
    _movieNowPlayingBloc = MovieNowPlayingBloc(getNowPlayingMoviesBloc);
    _movieTopRatedBloc = MovieTopRatedBloc(getTopRatedMoviesBloc);
    _movieSearchBloc = MovieSearchBloc(searchMovie);
    _movieWathclistBloc = MovieWathclistBloc(watchListsMovie);
  });

  testWidgets('Test', (tester) async {
    when(getNowPlayingMoviesBloc.execute()).thenAnswer((_) async => Right(testMovieList));
    when(getTopRatedMoviesBloc.execute()).thenAnswer((_) async => Right(testMovieList));
    when(getPopularMoviesBloc.execute()).thenAnswer((_) async => Right(testMovieList));
    when(watchListsMovie.getData()).thenAnswer((_) async => Right(testMovieList));
    await tester.pumpWidget(MultiBlocProvider(providers: [
      BlocProvider<MoviePopularBlocBloc>.value(value: _moviePopularBloc),
      BlocProvider<MovieTopRatedBloc>.value(value: _movieTopRatedBloc),
      BlocProvider<MovieNowPlayingBloc>.value(value: _movieNowPlayingBloc),
      BlocProvider<MovieWathclistBloc>.value(value: _movieWathclistBloc),
      BlocProvider<MovieSearchBloc>.value(value: _movieSearchBloc),
    ], child: MaterialApp(home: MovieListPage())));
    expect(find.byType(Container), findsWidgets);
  });
}
