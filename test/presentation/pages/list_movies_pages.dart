import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/domain/usecase/get_popular_movie.dart';
import 'package:dicoding_tv_series/domain/usecase/get_top_rated_movie.dart';
import 'package:dicoding_tv_series/domain/usecase/search_movie.dart';
import 'package:dicoding_tv_series/domain/usecase/watchlist_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_popular_bloc/movie_popular_bloc_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_search_bloc/movie_search_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_top_rated_bloc/movie_top_rated_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_watchlist_bloc/movie_wathclist_bloc.dart';
import 'package:dicoding_tv_series/presentation/pages/movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularMovie getPopularMovie;
  late GetTopRatedMovie getTopRatedMovie;
  late WatchListsMovie watchListsMovie;
  late SearchMovie searchMovie;
  late MockMovieRepository repository;

  setUp(() {
    repository = MockMovieRepository();
    getPopularMovie = GetPopularMovie(repository);
    getTopRatedMovie = GetTopRatedMovie(repository);
    searchMovie = SearchMovie(repository);
    watchListsMovie = WatchListsMovie(repository);
  });

  void popularMovie() {
    when(repository.getPopularMovies()).thenAnswer((_) async => Right(testMovieList));
  }

  void getSearchMovie() {
    when(repository.searchMovies(any)).thenAnswer((_) async => Right(testMovieList));
  }

  void topRatedMovie() {
    when(repository.getTopRatedMovies()).thenAnswer((_) async => Right(testMovieList));
  }

  void watchListMovie() {
    when(repository.getWatchlistMovies()).thenAnswer((_) async => Right(testMovieList));
  }

  testWidgets("Should loading when in movie list page", (tester) async {
    popularMovie();
    topRatedMovie();
    watchListMovie();
    getSearchMovie();
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<MoviePopularBlocBloc>(
            create: (context) => MoviePopularBlocBloc(getPopularMovie),
          ),
          BlocProvider<MovieTopRatedBloc>(
            create: (context) => MovieTopRatedBloc(getTopRatedMovie),
          ),
          BlocProvider<MovieWathclistBloc>(
            create: (context) => MovieWathclistBloc(watchListsMovie),
          ),
          BlocProvider<MovieSearchBloc>(
            create: (context) => MovieSearchBloc(searchMovie),
          ),
        ],
        child: MaterialApp(
          home: MovieListPage(),
        ),
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
