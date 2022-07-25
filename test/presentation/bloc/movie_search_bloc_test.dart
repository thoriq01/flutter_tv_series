import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/usecase/search_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_search_bloc/movie_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchMovie _getRecomendation;
  late MockMovieRepository _movieRepository;
  setUp(() {
    _movieRepository = MockMovieRepository();
    _getRecomendation = SearchMovie(_movieRepository);
  });
  final query = "jhon";
  group("", () {
    test("Should emit MovieNowPlayigLoaded", () async* {
      when(_getRecomendation.execute(query)).thenAnswer((_) async => Right(testMovieList));
      final bloc = MovieSearchBloc(_getRecomendation)..add(SearchMovieEvent(query));
      expectLater(bloc, emitsInOrder([MovieSearchBlocLoaded(testMovieList)]));
    });

    test("Should emit MovieNowPlayingError", () async* {
      when(_getRecomendation.execute(query)).thenAnswer((_) async => Left(ConnectionFailure("Error")));
      final bloc = MovieSearchBloc(_getRecomendation)..add(SearchMovieEvent(query));
      expectLater(bloc, emitsInOrder([MovieSearchBlocError("Error")]));
    });
  });
  blocTest<MovieSearchBloc, MovieSearchBlocState>(
    "Test Bloc",
    build: () {
      when(_getRecomendation.execute(query)).thenAnswer((_) async => Right(testMovieList));
      return MovieSearchBloc(_getRecomendation);
    },
    act: (bloc) => bloc.add(SearchMovieEvent(query)),
    expect: () => [MovieSearchBlocInitial(), MovieSearchBlocLoading(), MovieSearchBlocLoaded(testMovieList)],
  );
  final message = "Error";

  blocTest<MovieSearchBloc, MovieSearchBlocState>(
    "Test Bloc",
    build: () {
      when(_getRecomendation.execute(query)).thenAnswer((_) async => Left(ServerFailure(message)));
      return MovieSearchBloc(_getRecomendation);
    },
    act: (bloc) => bloc.add(SearchMovieEvent(query)),
    expect: () => [isA<MovieSearchBlocInitial>(), isA<MovieSearchBlocLoading>(), isA<MovieSearchBlocError>()],
  );
  blocTest<MovieSearchBloc, MovieSearchBlocState>(
    "Test Bloc",
    build: () {
      when(_getRecomendation.execute(query)).thenAnswer((_) async => Left(ServerFailure(message)));
      return MovieSearchBloc(_getRecomendation);
    },
    act: (bloc) => bloc.add(RemoveSearchMovieEvent()),
    expect: () => [isA<MovieSearchBlocEmpty>()],
  );

  test("Test event", () {
    final load = SearchMovieEvent(query);
    expect(load.query, query);
  });
  test("Test event", () {
    final load = SearchMovieEvent(query);
    expect(load.props, [query]);
  });
  test("Test event", () {
    final load = RemoveSearchMovieEvent();
    expect(load.props, []);
  });
}
