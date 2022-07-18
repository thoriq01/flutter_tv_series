import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/domain/usecase/get_detail_movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../dummy_data/dummy_objects.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late GetDetailMovie getDetailMovie;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    getDetailMovie = GetDetailMovie(mockMovieRepository);
  });

  final int id = 1;

  test('should get movie detail from the repository', () async {
    // arrange
    when(mockMovieRepository.getMovieDetail(id)).thenAnswer((_) async => Right(testMovieDetail));
    // act
    final result = await getDetailMovie.execute(id);
    // assert
    expect(result, Right(testMovieDetail));
  });
}
