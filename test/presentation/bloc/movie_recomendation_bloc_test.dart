import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/usecase/get_recomendation_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_now_playing_bloc/movie_now_playing_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_recomendation_bloc/movie_recomendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

class _GetRecomendation extends Mock implements GetRecomendation {}

void main() {
  late GetRecomendation _getRecomendation;
  late MockMovieRepository _movieRepository;
  setUp(() {
    _movieRepository = MockMovieRepository();
    _getRecomendation = GetRecomendation(_movieRepository);
  });
  group("", () {
    test("Should emit MovieNowPlayigLoaded", () async* {
      when(_getRecomendation.execute(58122)).thenAnswer((_) async => Right(testMovieList));
      final bloc = MovieRecomendationBloc(_getRecomendation)..add(LoadMovieRecomendation(58122));
      expectLater(bloc, emitsInOrder([MovieNowPlayingLoaded(testMovieList)]));
    });

    test("Should emit MovieNowPlayingError", () async* {
      when(_getRecomendation.execute(58122)).thenAnswer((_) async => Left(ConnectionFailure("Error")));
      final bloc = MovieRecomendationBloc(_getRecomendation)..add(LoadMovieRecomendation(58122));
      expectLater(bloc, emitsInOrder([MovieNowPlayingError("Error")]));
    });
  });
  blocTest<MovieRecomendationBloc, MovieRecomendationState>(
    "Test Bloc",
    build: () {
      when(_getRecomendation.execute(58122)).thenAnswer((_) async => Right(testMovieList));
      return MovieRecomendationBloc(_getRecomendation);
    },
    act: (bloc) => bloc.add(LoadMovieRecomendation(58122)),
    expect: () => [MovieRecomendationInitial(), MovieRecomendationLoading(), MovieRecomendationLoaded(testMovieList)],
  );
  final message = "Error";
  // blocTest<MovieRecomendationBloc, MovieRecomendationState>(
  //   "Test Bloc",
  //   build: () {
  //     when(_getRecomendation.execute(58122)).thenAnswer((_) async => Left(ConnectionFailure(message)));
  //     return MovieRecomendationBloc(_getRecomendation);
  //   },
  //   act: (bloc) => bloc.add(LoadMovieRecomendation(58122)),
  //   errors: (() => []),
  // );
  blocTest<MovieRecomendationBloc, MovieRecomendationState>(
    "Test Bloc",
    build: () {
      when(_getRecomendation.execute(-300)).thenAnswer((_) async => Left(ServerFailure(message)));
      return MovieRecomendationBloc(_getRecomendation);
    },
    act: (bloc) => bloc.add(LoadMovieRecomendation(-300)),
    expect: () => [isA<MovieRecomendationInitial>(), isA<MovieRecomendationLoading>(), isA<MovieRecomendationError>()],
  );

  test("Test event", () {
    final load = LoadMovieRecomendation(58122);
    expect(load.movieId, 58122);
  });

  test("Test event", () {
    final load = LoadMovieRecomendation(58122);
    expect(load.props, [58122]);
  });
}
