import 'package:dicoding_tv_series/domain/usecase/get_top_rated_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_top_rated_bloc/movie_top_rated_bloc.dart';
import 'package:dicoding_tv_series/presentation/widget/movie_toprated_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedMovie getTopRatedMovie;
  late MockMovieRepository movieRepository;
  late MovieTopRatedBloc movieTopRatedBloc;

  setUp(() {
    movieRepository = MockMovieRepository();
    getTopRatedMovie = GetTopRatedMovie(movieRepository);
    movieTopRatedBloc = MovieTopRatedBloc(getTopRatedMovie);
  });
  _makeTestableWidget(Widget body) {
    return (BlocProvider<MovieTopRatedBloc>.value(value: movieTopRatedBloc, child: MaterialApp(home: body)));
  }

  testWidgets("Test ", (tester) async {
    await tester.pumpWidget(_makeTestableWidget(MovieTopRatedWidget()));
    expect(find.byType(Container), findsOneWidget);
  });
}
