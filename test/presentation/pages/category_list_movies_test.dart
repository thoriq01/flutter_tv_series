import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/domain/usecase/get_popular_movie.dart';
import 'package:dicoding_tv_series/domain/usecase/get_top_rated_movie.dart';
import 'package:dicoding_tv_series/domain/usecase/watchlist_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_popular_bloc/movie_popular_bloc_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_top_rated_bloc/movie_top_rated_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_watchlist_bloc/movie_wathclist_bloc.dart';
import 'package:dicoding_tv_series/presentation/pages/movie_type_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository repository;
  late GetPopularMovie getPopularMovie;
  late GetTopRatedMovie getTopRatedMovie;
  late WatchListsMovie watchListsMovie;
  setUp(() {
    repository = MockMovieRepository();
    getPopularMovie = GetPopularMovie(repository);
    getTopRatedMovie = GetTopRatedMovie(repository);
    watchListsMovie = WatchListsMovie(repository);
  });

  void popularMovie() {
    when(repository.getPopularMovies()).thenAnswer((_) async => Right(testMovieList));
  }

  void topratedMovie() {
    when(repository.getTopRatedMovies()).thenAnswer((_) async => Right(testMovieList));
  }

  void watchlist() {
    when(repository.getWatchlistMovies()).thenAnswer((_) async => Right(testMovieList));
  }

  group("List Popular Movie", () {
    testWidgets("Should render loading", (testest) async {
      popularMovie();
      await testest.pumpWidget(MaterialApp(
          home: BlocProvider<MoviePopularBlocBloc>(
        create: (context) => MoviePopularBlocBloc(getPopularMovie),
        child: MovieTypeListPage(category: "popular"),
      )));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group("List Toprated  Movie", () {
    testWidgets("Should render loading", (testest) async {
      topratedMovie();
      await testest.pumpWidget(MaterialApp(
          home: BlocProvider<MovieTopRatedBloc>(
        create: (context) => MovieTopRatedBloc(getTopRatedMovie),
        child: MovieTypeListPage(category: "topmovie"),
      )));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
  group("List Watchlist  Movie", () {
    testWidgets("Should render text", (testest) async {
      watchlist();
      await testest.pumpWidget(MaterialApp(
          home: BlocProvider<MovieWathclistBloc>(
        create: (context) => MovieWathclistBloc(watchListsMovie),
        child: MovieTypeListPage(category: "watchlist"),
      )));
      expect(find.text("Watchlist"), findsOneWidget);
    });
  });
}
