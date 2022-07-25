import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/usecase/get_top_rated_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_top_rated_bloc/movie_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'get_popular_movies_bloc.mocks.dart';

class _GetTopRatedMovie extends Mock implements GetTopRatedMovie {}

void main() {
  late MockMovieRepository _movieRepository;
  late GetTopRatedMovie getTopRatedMovie;
  final movie = <Movie>[];
  final message = "Error";
  setUp(() {
    _movieRepository = MockMovieRepository();
    getTopRatedMovie = GetTopRatedMovie(_movieRepository);
  });
  group("Top Rated Movie", () {
    test("Should emit MovieTopRatedLoaded ", () async* {
      when(getTopRatedMovie.execute()).thenAnswer((_) async => Right(movie));

      final bloc = MovieTopRatedBloc(getTopRatedMovie)..add(LoadMovieTopRated());

      expect(bloc, emitsInOrder([MovieTopRatedLoaded(movie)]));
    });

    test("Should emit MovieTopRatedError ", () async* {
      when(getTopRatedMovie.execute()).thenAnswer((_) async => Left(ServerFailure(message)));

      final bloc = MovieTopRatedBloc(getTopRatedMovie)..add(LoadMovieTopRated());

      expect(bloc, emitsInOrder([MovieTopRatedError(message)]));
    });
  });
  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    "Test Bloc",
    build: () {
      when(getTopRatedMovie.execute()).thenAnswer((_) async => Right(testMovieList));
      return MovieTopRatedBloc(getTopRatedMovie);
    },
    act: (bloc) => bloc.add(LoadMovieTopRated()),
    expect: () => [
      isA<MovieTopRatedLoading>(),
      isA<MovieTopRatedLoaded>(),
    ],
  );
  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    "Test Bloc",
    build: () {
      when(getTopRatedMovie.execute()).thenAnswer((_) async => Left(ServerFailure(message)));
      return MovieTopRatedBloc(getTopRatedMovie);
    },
    act: (bloc) => bloc.add(LoadMovieTopRated()),
    expect: () => [
      isA<MovieTopRatedLoading>(),
      isA<MovieTopRatedError>(),
    ],
  );
  test("Test event", () {
    final load = LoadMovieTopRated();
    expect(load.props, []);
  });
}
