import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/domain/usecase/get_top_rated_movie.dart';
import 'package:dicoding_tv_series/domain/usecase/watchlist_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_top_rated_bloc/movie_top_rated_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_watchlist_bloc/movie_wathclist_bloc.dart';
import 'package:dicoding_tv_series/presentation/pages/movie_list.dart';
import 'package:dicoding_tv_series/presentation/widget/movie_toprated_widget.dart';
import 'package:dicoding_tv_series/presentation/widget/movie_watchlist_widget.dart';
import 'package:dicoding_tv_series/presentation/widget/title_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';
import 'movie_watchlist_widget_test_mocks.dart';
import 'movie_watchlist_widget_test_mocks.dart';

@GenerateMocks([MovieWathclistBloc])
void main() {
  late WatchListsMovie getTopRatedMovie;
  late MockMovieRepository movieRepository;
  late MovieWathclistBloc movieWathclistBloc;
  late MockMovieWathclistBloc bloc;

  setUp(() {
    movieRepository = MockMovieRepository();
    getTopRatedMovie = WatchListsMovie(movieRepository);
    // movieWathclistBloc = MovieWathclistBloc(getTopRatedMovie);
    movieWathclistBloc = MovieWathclistBloc(getTopRatedMovie);
    bloc = MockMovieWathclistBloc();
  });
  _makeTestableWidget(Widget body) {
    return (BlocProvider<MovieWathclistBloc>.value(value: movieWathclistBloc, child: MaterialApp(home: body)));
  }

  testWidgets("Test ", (tester) async {
    when(getTopRatedMovie.getData()).thenAnswer((realInvocation) async => Right(testMovieList));
    await tester.pumpWidget(_makeTestableWidget(MovieWatchlistWidget()));
    expect(find.byType(Container), findsOneWidget);
  });
  testWidgets("Test ", (tester) async {
    when(getTopRatedMovie.getData()).thenAnswer((realInvocation) async => Right(testMovieList));
    when(bloc.state).thenReturn(MovieWatchlistError("Erro"));
    await tester.pumpWidget(_makeTestableWidget(MovieWatchlistWidget()));
    expect(find.byType(Container), findsOneWidget);
  });
}
