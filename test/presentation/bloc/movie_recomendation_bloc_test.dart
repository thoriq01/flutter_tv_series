import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/usecase/get_recomendation_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_now_playing_bloc/movie_now_playing_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_recomendation_bloc/movie_recomendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';

class _GetRecomendation extends Mock implements GetRecomendation {}

void main() {
  late _GetRecomendation _getNowPlaying;
  setUp(() {
    _getNowPlaying = _GetRecomendation();
  });

  test("Should emit MovieNowPlayigLoaded", () async* {
    when(_getNowPlaying.execute(58122)).thenAnswer((_) async => Right(testMovieList));
    final bloc = MovieRecomendationBloc(_getNowPlaying)..add(LoadMovieRecomendation(58122));
    expect(bloc, emitsInOrder([MovieNowPlayingLoaded(testMovieList)]));
  });

  test("Should emit MovieNowPlayingError", () async* {
    when(_getNowPlaying.execute(58122)).thenAnswer((_) async => Left(ConnectionFailure("Error")));
    final bloc = MovieRecomendationBloc(_getNowPlaying)..add(LoadMovieRecomendation(58122));
    expect(bloc, emitsInOrder([MovieNowPlayingError("Error")]));
  });
}
