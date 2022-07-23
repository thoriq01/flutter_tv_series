import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/usecase/get_now_playing_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_now_playing_bloc/movie_now_playing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';

class _GetNowPlaying extends Mock implements GetNowPlaying {}

void main() {
  late _GetNowPlaying _getNowPlaying;
  setUp(() {
    _getNowPlaying = _GetNowPlaying();
  });

  test("Should emit MovieNowPlayigLoaded", () async* {
    when(_getNowPlaying.execute()).thenAnswer((_) async => Right(testMovieList));
    final bloc = MovieNowPlayingBloc(_getNowPlaying)..add(LoadMovieNowPlaying());
    expect(bloc, emitsInOrder([MovieNowPlayingLoaded(testMovieList)]));
  });

  test("Should emit MovieNowPlayingError", () async* {
    when(_getNowPlaying.execute()).thenAnswer((_) async => Left(ConnectionFailure("Error")));
    final bloc = MovieNowPlayingBloc(_getNowPlaying)..add(LoadMovieNowPlaying());
    expect(bloc, emitsInOrder([MovieNowPlayingError("Error")]));
  });
}
