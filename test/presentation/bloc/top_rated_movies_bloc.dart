import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/usecase/get_top_rated_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_top_rated_bloc/movie_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class _GetTopRatedMovie extends Mock implements GetTopRatedMovie {}

void main() {
  late _GetTopRatedMovie getTopRatedMovie;

  final movie = <Movie>[];
  final message = "Error";
  setUp(() {
    getTopRatedMovie = _GetTopRatedMovie();
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
}
