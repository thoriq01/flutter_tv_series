import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/usecase/get_now_playing_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_now_playing_bloc/movie_now_playing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

class _GetNowPlaying extends Mock implements GetNowPlaying {}

void main() {
  late GetNowPlaying _getNowPlaying;
  late MockMovieRepository _movieRepository;
  setUp(() {
    _movieRepository = MockMovieRepository();
    _getNowPlaying = GetNowPlaying(_movieRepository);
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
  blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
    "Test Bloc",
    build: () {
      when(_getNowPlaying.execute()).thenAnswer((_) async => Right(testMovieList));
      return MovieNowPlayingBloc(_getNowPlaying);
    },
    act: (bloc) => bloc.add(LoadMovieNowPlaying()),
    expect: () => [MovieNowPlayingInitial(), MovienowPlayingLoading(), MovieNowPlayingLoaded(testMovieList)],
  );
  final message = "Error";

  blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
    "Test Bloc",
    build: () {
      when(_getNowPlaying.execute()).thenAnswer((_) async => Left(ServerFailure(message)));
      return MovieNowPlayingBloc(_getNowPlaying);
    },
    act: (bloc) => bloc.add(LoadMovieNowPlaying()),
    expect: () => [isA<MovieNowPlayingInitial>(), isA<MovienowPlayingLoading>(), isA<MovieNowPlayingError>()],
  );
  test("Aku tidak tahu test apa ini", () {
    final load = LoadMovieNowPlaying();
    expect(load.props, []);
  });
}
