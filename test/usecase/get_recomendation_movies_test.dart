import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/usecase/get_recomendation_movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../dummy_data/dummy_objects.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository repository;
  late GetRecomendation recomendation;

  setUp(() {
    repository = MockMovieRepository();
    recomendation = GetRecomendation(repository);
  });
  final message = "Connection Failed";
  void getRecomendation() async {
    when(repository.getMovieRecommendations(12)).thenAnswer((_) async => right(testMovieList));
  }

  test("Should right list movie", () async {
    getRecomendation();
    final result = await recomendation.execute(12);

    expect(result, Right(testMovieList));
  });

  test("Should left a massege when failure heheh", () async {
    when(repository.getMovieRecommendations(12)).thenAnswer((_) async => Left(ConnectionFailure(message)));
    final result = await recomendation.execute(12);
    expect(result, Left(ConnectionFailure(message)));
  });
}
