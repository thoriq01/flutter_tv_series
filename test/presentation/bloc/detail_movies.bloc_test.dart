import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/usecase/get_detail_movie.dart';
import 'package:dicoding_tv_series/domain/usecase/get_top_rated_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_top_rated_bloc/movie_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';

class _GetDetailMovie extends Mock implements GetDetailMovie {}

void main() {
  late _GetDetailMovie _getDetailMovie;

  final message = "Error";
  final id = 1;
  setUp(() {
    _getDetailMovie = _GetDetailMovie();
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
}
