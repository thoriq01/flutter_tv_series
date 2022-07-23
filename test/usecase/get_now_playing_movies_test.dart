import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/usecase/get_now_playing_movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../dummy_data/dummy_objects.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository repository;
  late GetNowPlaying recomendation;

  setUp(() {
    repository = MockMovieRepository();
    recomendation = GetNowPlaying(repository);
  });
  final message = "Connection Failed";
  void getRecomendation() async {
    when(repository.getNowPlayingMovies()).thenAnswer((_) async => Right(testMovieList));
  }

  test("Should right list movie", () async {
    getRecomendation();
    final result = await recomendation.execute();

    expect(result, Right(testMovieList));
  });

  test("Should left a massege when failure heheh", () async {
    when(repository.getNowPlayingMovies()).thenAnswer((_) async => Left(ConnectionFailure(message)));
    final result = await recomendation.execute();
    expect(result, Left(ConnectionFailure(message)));
  });
}
