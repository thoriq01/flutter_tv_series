import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/usecase/get_popular_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_popular_bloc/movie_popular_bloc_bloc.dart';
import 'package:dicoding_tv_series/presentation/pages/movie_list.dart';
import 'package:dicoding_tv_series/presentation/widget/movie_popular_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../bloc/get_popular_movies_bloc.mocks.dart';
import 'movie_populart_widget_mocks.dart';

@GenerateMocks([MoviePopularBlocBloc])
void main() {
  late GetPopularMovie getPopularMovie;
  late MockMovieRepository mockMovieRepository;
  late MockMoviePopularBlocBloc mockPopular;
  late MoviePopularBlocBloc bloc;
  setUp(() {
    mockMovieRepository = MockMovieRepository();
    getPopularMovie = GetPopularMovie(mockMovieRepository);
    bloc = MoviePopularBlocBloc(getPopularMovie);
    mockPopular = MockMoviePopularBlocBloc();
  });

  _makeTestableWidget(Widget body) {
    return (BlocProvider<MoviePopularBlocBloc>.value(value: bloc, child: MaterialApp(home: body)));
  }

  _makeThisTestShit() {
    when(getPopularMovie.execute()).thenAnswer((_) async => Right(testMovieList));
    when(mockPopular.state).thenReturn(MoviePopularLoaded(testMovieList));
  }

  group("Aku tidak paham", () {
    testWidgets("Should Anjay", (tester) async {
      _makeThisTestShit();
      await tester.pumpWidget(_makeTestableWidget(MoviePopularBlocWidget()));
      expect(find.byType(Container), findsOneWidget);
    });
  });
}
