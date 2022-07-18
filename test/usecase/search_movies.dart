import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/usecase/search_movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late SearchMovie searchMovie;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    searchMovie = SearchMovie(mockMovieRepository);
  });
  final tMovies = <Movie>[];
  final String query = "minions";

  test('should get top rated movie from the repository', () async {
    // arrange
    when(mockMovieRepository.searchMovies(query)).thenAnswer((_) async => Right(tMovies));
    // act
    final result = await searchMovie.execute(query);
    // assert
    expect(result, Right(tMovies));
  });
}
