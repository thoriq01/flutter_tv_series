import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/usecase/get_top_rated_movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedMovie getTopRated;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    getTopRated = GetTopRatedMovie(mockMovieRepository);
  });
  final tMovies = <Movie>[];

  test('should get top rated movie from the repository', () async {
    // arrange
    when(mockMovieRepository.getTopRatedMovies()).thenAnswer((_) async => Right(tMovies));
    // act
    final result = await getTopRated.execute();
    // assert
    expect(result, Right(tMovies));
  });
}
