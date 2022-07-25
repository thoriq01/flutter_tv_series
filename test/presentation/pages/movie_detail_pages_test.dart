import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/domain/entities/cast.dart';
import 'package:dicoding_tv_series/domain/entities/genre.dart';
import 'package:dicoding_tv_series/domain/entities/movie_detail.dart';
import 'package:dicoding_tv_series/domain/usecase/get_cast_movie.dart';
import 'package:dicoding_tv_series/domain/usecase/get_detail_movie.dart';
import 'package:dicoding_tv_series/domain/usecase/get_recomendation_movie.dart';
import 'package:dicoding_tv_series/domain/usecase/watchlist_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_cast_bloc/movie_cast_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_recomendation_bloc/movie_recomendation_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_watchlist_bloc/movie_wathclist_bloc.dart';
import 'package:dicoding_tv_series/presentation/pages/movie_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository repository;
  late GetDetailMovie getDetailMovie;
  late GetRecomendation getRecomendation;
  late WatchListsMovie watchListsMovie;
  late GetMovieCast getMovieCast;

  late MovieDetailBloc movieDetailBloc;
  late MovieCastBloc movieCastBloc;
  late MovieRecomendationBloc movieRecomendationBloc;
  late MovieWathclistBloc movieWathclistBloc;
  setUp(() {
    repository = MockMovieRepository();
    getDetailMovie = GetDetailMovie(repository);
    getRecomendation = GetRecomendation(repository);
    watchListsMovie = WatchListsMovie(repository);
    getMovieCast = GetMovieCast(repository);

    movieDetailBloc = MovieDetailBloc(getDetailMovie);
    movieCastBloc = MovieCastBloc(getMovieCast);
    movieRecomendationBloc = MovieRecomendationBloc(getRecomendation);
    movieWathclistBloc = MovieWathclistBloc(watchListsMovie);
  });
  var movieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 438148,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );
  final id = 438148;
  final moviCast = <MovieCastEntities>[];

  testWidgets("renders loading", (WidgetTester tester) async {
    when(getDetailMovie.execute(id)).thenAnswer((_) async => Right(movieDetail));
    when(getRecomendation.execute(id)).thenAnswer((_) async => Right(testMovieList));
    when(getMovieCast.execute(id)).thenAnswer((_) async => Right(moviCast));
    when(watchListsMovie.isAddWatchlist(id)).thenAnswer((_) async => true);

    await tester.pumpWidget(
      MultiBlocProvider(providers: [
        BlocProvider<MovieDetailBloc>.value(
          value: movieDetailBloc,
        ),
        BlocProvider<MovieCastBloc>.value(
          value: movieCastBloc,
        ),
        BlocProvider<MovieRecomendationBloc>.value(
          value: movieRecomendationBloc,
        ),
        BlocProvider<MovieWathclistBloc>.value(
          value: movieWathclistBloc,
        ),
      ], child: MaterialApp(home: MovieDetailPage(movie: movieDetail))),
    );
    expect(find.byType(Text), findsWidgets);
  });
}
