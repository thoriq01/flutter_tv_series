import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/usecase/get_detail_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_top_rated_bloc/movie_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'get_popular_movies_bloc.mocks.dart';

void main() {
  late GetDetailMovie _getDetailMovie;
  late MockMovieRepository _movieRepository;
  final message = "Error";
  final id = 1;
  setUp(() {
    _movieRepository = MockMovieRepository();
    _getDetailMovie = GetDetailMovie(_movieRepository);
  });
  group("Top Rated Movie", () {
    test("Should emit MovieTopRatedLoaded ", () async* {
      when(_getDetailMovie.execute(id)).thenAnswer((_) async => Right(testMovieDetail));

      final bloc = MovieDetailBloc(_getDetailMovie)..add(LoadMovieDetail(id));

      expect(bloc, emitsInOrder([MovieDetailLoaded(testMovieDetail)]));
    });

    test("Should emit MovieTopRatedError ", () async* {
      when(_getDetailMovie.execute(id)).thenAnswer((_) async => Left(ServerFailure(message)));

      final bloc = MovieDetailBloc(_getDetailMovie)..add(LoadMovieDetail(id));

      expect(bloc, emitsInOrder([MovieTopRatedError(message)]));
    });
  });
  blocTest<MovieDetailBloc, MovieDetailState>(
    "Test Bloc",
    build: () {
      when(_getDetailMovie.execute(id)).thenAnswer((_) async => Right(testMovieDetail));
      return MovieDetailBloc(_getDetailMovie);
    },
    act: (bloc) => bloc.add(LoadMovieDetail(id)),
    expect: () => [
      isA<MovieDetailLoading>(),
      isA<MovieDetailLoaded>(),
    ],
  );
  blocTest<MovieDetailBloc, MovieDetailState>(
    "Test Bloc",
    build: () {
      when(_getDetailMovie.execute(id)).thenAnswer((_) async => Left(ServerFailure(message)));
      return MovieDetailBloc(_getDetailMovie);
    },
    act: (bloc) => bloc.add(LoadMovieDetail(id)),
    expect: () => [
      isA<MovieDetailLoading>(),
      isA<MovieDetailError>(),
    ],
  );
  test("Test", () {
    final load = LoadMovieDetail(id);
    expect(load.id, 1);
    expect(load.props, [1]);
  });
  test("Test", () {
    final load = TestMovieDetail();
    expect(load.props, []);
  });
}
