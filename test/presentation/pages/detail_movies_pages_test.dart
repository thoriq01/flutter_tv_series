import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/domain/entities/genre.dart';
import 'package:dicoding_tv_series/domain/entities/movie_detail.dart';
import 'package:dicoding_tv_series/domain/usecase/get_detail_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:dicoding_tv_series/presentation/pages/movie_detail_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetDetailMovie detailBloc;
  late MockMovieRepository repository;
  setUp(() {
    repository = MockMovieRepository();
    detailBloc = GetDetailMovie(repository);
  });
  var movieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );
  void getMovieDetail() {
    when(repository.getMovieDetail(any)).thenAnswer((_) async => Right(movieDetail));
  }

  testWidgets("renders loading", (WidgetTester tester) async {
    getMovieDetail();
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) => MovieDetailBloc(detailBloc),
          child: MovieDetailPages(id: movieDetail),
        ),
      ),
    );
    expect(find.text("Loading"), findsOneWidget);
  });

  testWidgets("renders Contianer when loaded", (WidgetTester tester) async {
    getMovieDetail();
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) => MovieDetailBloc(detailBloc),
          child: MovieDetailPages(id: movieDetail),
        ),
      ),
    );
    expect(find.byType(Container), findsOneWidget);
  });
}
